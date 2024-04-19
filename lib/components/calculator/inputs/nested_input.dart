import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klimo/common/buttons/save_icon_button.dart';
import 'package:klimo/common/dialogs/confirmation_dialog.dart';
import 'package:klimo/common/layout/klimo_bottom_sheet.dart';
import 'package:klimo/components/calculator/cubit/calculator_cubit.dart';
import 'package:klimo/components/calculator/cubit/calculator_value_scope_cubit.dart';
import 'package:klimo/config/icons.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/calculation_engine.dart';
import 'package:klimo_datamodels/input_model.dart' as model;

import 'calculator_input.dart';
import 'input_controller.dart';
import 'input_layout.dart';

String? mapEntityToIcon(String entityKey) {
  return {
    // mobility.means_of_transport
    "car": KlimoIcons.car,
    "motorcycle": KlimoIcons.motorcycle,
    "public_transport": KlimoIcons.carSharing1,
    "bicycle": KlimoIcons.bike,
    "scooter": KlimoIcons.kickScooter,
    // consumption.pets
    "dog": KlimoIcons.dog,
    "cat": KlimoIcons.cat,
    "horse": KlimoIcons.horse,
    "rodent": KlimoIcons.rodent,
    "bird": KlimoIcons.bird,
    "reptiles": KlimoIcons.reptile,
    "fish": KlimoIcons.fish,
    // consumption.vacation
    "active": KlimoIcons.hiking,
    "beach": KlimoIcons.beach,
    "family": KlimoIcons.family,
    "skiing": KlimoIcons.skiing,
    "cultural": KlimoIcons.cultural,
    "cruise": KlimoIcons.cruise,
    "balcony": KlimoIcons.stayHome,
  }[entityKey];
}

class NestedInput extends StatefulWidget {
  final model.NestedEntityInput input;

  const NestedInput({Key? key, required this.input}) : super(key: key);

  @override
  State<NestedInput> createState() => _NestedInputState();
}

class _NestedInputState extends State<NestedInput> {
  @override
  Widget build(BuildContext context) {
    final fullKey = context
        .select((CalculatorValueScopeCubit c) => c.getFullKey(widget.input));

    final title = widget.input.title.tr(context);
    final description = widget.input.description?.tr(context) ?? "";
    return InputLayout(
      fullKey,
      title: title,
      description: description,
      valueWidget: TextButton.icon(
        onPressed: () {
          _showAddEntitySheet(context);
        },
        label: Text(context.localisation().action_add),
        icon: const Icon(
          Icons.add_circle,
        ),
      ),
      child: InputController(
        input: widget.input,
        builder: (context, value, setValue) {
          final items = _currentValue(value)?.toList();
          // if items are null default values for nested inputs will be applied
          if (items == null) {
            debugPrint(
                "Standardprofil (${widget.input.defaultValue?.join(",")})");
            // TODO: display fancy empty state
            return Container();
          }

          if (items.isNotEmpty) {
            final indices = Iterable<int>.generate(items.length);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...indices.map((i) {
                  var repeatedItems = items
                      .where((element) => element.entity == items[i].entity)
                      .toList();
                  int? repeatedIndex;
                  if (repeatedItems.length > 1 &&
                      repeatedItems.contains(items[i])) {
                    repeatedIndex = repeatedItems.indexOf(items[i]) + 1;
                  }
                  return EntityItem(
                    index: i + 1,
                    repeatedIndex: repeatedIndex,
                    entity: widget.input.entityTypes
                        .singleWhere((e) => e.key == items[i].entity),
                    values: items[i],
                    emissionValue: context
                        .read<CalculatorCubit>()
                        .unstable__getNestedValue(widget.input, i) as double?,
                    onPressed: () {
                      _editEntity(context, items[i]);
                    },
                    onDismissed: () {
                      _deleteEntity(context, items[i]);
                    },
                  );
                }).toList(),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    context.localisation().calculator_nested_input_hint,
                    textAlign: TextAlign.center,
                    style: context
                        .textTheme()
                        .labelMedium
                        ?.copyWith(color: Palette.grey),
                  ),
                ),
              ],
            );
          } else {
            // TODO: display fancy empty state
            return Container();
          }
        },
      ),
    );
  }

  void _addEntity(BuildContext context, model.NestedEntity entity) async {
    final nestedValues = await _openEntity(
        context,
        entity,
        (_) => CalculatorValueScopeCubit(
            scope: entity,
            initialValues: NestedValues.empty(entity.key),
            fullPathPrefix: _getFullPath(context, entity) ?? ""));

    if (nestedValues != null) {
      if (!mounted) return;
      final scope = context.read<CalculatorValueScopeCubit>();
      final current = scope.getInputValue(widget.input) as BuiltList<Object>? ??
          BuiltList();
      scope.setUserInput(
          widget.input, current.rebuild((c) => c.add(nestedValues)));
      context.read<CalculatorCubit>().scheduleSave();
    }
  }

  Widget _buildNestedCalculator(
      BuildContext context, model.NestedEntity entity) {
    return KlimoBottomSheet(
      header: KlimoBottomSheetHeader(
        title: entity.title.tr(context),
        action: BlocBuilder<TouchedValueScopeCubit, bool>(
            bloc: context.read<CalculatorValueScopeCubit>().touchedCubit,
            builder: (context, state) {
              return SaveIconButton(
                onClick: state
                    ? () => Navigator.pop(context,
                        context.read<CalculatorValueScopeCubit>().state)
                    : null,
                hintText: context.localisation().action_save,
              );
            }),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: entity.inputs
              .map(
                (input) => CalculatorInput(input: input),
              )
              .toList(),
        ),
      ),
    );
  }

  Iterable<NestedValues>? _currentValue(Object? value) {
    return (value as BuiltList<Object>?)?.cast<NestedValues>();
  }

  void _deleteEntity(BuildContext context, NestedValues values) {
    final scope = context.read<CalculatorValueScopeCubit>();
    final current =
        scope.getInputValue(widget.input) as BuiltList<Object>? ?? BuiltList();
    scope.setUserInput(widget.input, current.rebuild((c) {
      final i = current.indexOf(values);
      c.removeAt(i);
    }));
    context.read<CalculatorCubit>().scheduleSave();
  }

  void _editEntity(BuildContext context, NestedValues values) async {
    final entity =
        widget.input.entityTypes.singleWhere((e) => e.key == values.entity);
    final nestedValues = await _openEntity(
        context,
        entity,
        (_) => CalculatorValueScopeCubit(
            scope: entity,
            initialValues: values,
            fullPathPrefix: _getFullPath(context, entity) ?? "")
          ..touchedCubit.touch());

    if (nestedValues != null) {
      if (!mounted) return;

      final scope = context.read<CalculatorValueScopeCubit>();
      final current = scope.getInputValue(widget.input) as BuiltList<Object>? ??
          BuiltList();
      scope.setUserInput(widget.input, current.rebuild((c) {
        final i = current.indexOf(values);
        c[i] = nestedValues;
      }));
      context.read<CalculatorCubit>().scheduleSave();
    }
  }

  Future<NestedValues?> _openEntity(
    BuildContext context,
    model.NestedEntity entity,
    CalculatorValueScopeCubit Function(BuildContext) createValueScopeCubit,
  ) {
    return showKlimoModalBottomSheet<NestedValues>(
        context: context,
        builder: (innerContext) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: createValueScopeCubit),
                ],
                child: Builder(
                    builder: (context) =>
                        _buildNestedCalculator(context, entity))));
  }

  void _showAddEntitySheet(BuildContext context) async {
    final scope = context.read<CalculatorValueScopeCubit>();
    final current = _currentValue(scope.getInputValue(widget.input)) ?? [];
    // filtered list of the remaining entityTypes, after evaluating the allowRepeated property
    final availableTypes = widget.input.entityTypes.where((e) {
      if (e.allowRepeated ?? widget.input.allowRepeated) return true;
      return !current.any((v) => v.entity == e.key);
    }).toBuiltSet();

    final entity = await showKlimoModalBottomSheet<model.NestedEntity>(
      context: context,
      builder: (context) => KlimoBottomSheet(
        header: KlimoBottomSheetHeader(
          title: widget.input.title.tr(context),
        ),
        body: AddNewEntityList(
            entityTypes: availableTypes,
            onSelect: (entity) => Navigator.pop(context, entity)),
      ),
    );
    if (!mounted) return;

    if (entity != null) _addEntity(context, entity);
  }

  String? _getFullPath(BuildContext context, model.NestedEntity entity) {
    final start =
        context.read<CalculatorValueScopeCubit>().getFullKey(widget.input);
    return start != null ? "$start.${entity.key}" : null;
  }
}

class AddNewEntityList extends StatelessWidget {
  final BuiltSet<model.NestedEntity> entityTypes;
  final void Function(model.NestedEntity) onSelect;

  const AddNewEntityList({
    Key? key,
    required this.entityTypes,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: entityTypes
          .map(
            (entity) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: EntityLayout(
                onPressed: () => onSelect(entity),
                icon: mapEntityToIcon(entity.key),
                title: entity.title.tr(context),
              ),
            ),
          )
          .toList(),
    );
  }
}

class EntityCard extends StatelessWidget {
  final Widget? child;
  final void Function() onPressed;

  const EntityCard({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: child,
        ),
      ),
    );
  }
}

class EntityItem extends StatelessWidget {
  final int index;
  final int? repeatedIndex;
  final model.NestedEntity entity;
  final NestedValues values;
  final double? emissionValue;
  final void Function() onPressed;
  final void Function()? onDismissed;

  const EntityItem({
    Key? key,
    required this.index,
    this.repeatedIndex,
    required this.entity,
    required this.values,
    required this.emissionValue,
    required this.onPressed,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Palette.red.withAlpha(50),
            ),
          ),
        ),
        Dismissible(
          key: ObjectKey(values),
          direction: onDismissed != null
              ? DismissDirection.horizontal
              : DismissDirection.none,
          confirmDismiss: (_) async {
            return (await showDialog<bool>(
                  context: context,
                  builder: (innerContext) => ConfirmationDialog(
                    title: context
                        .localisation()
                        .remove_calculator_group_input_title,
                    content: context
                        .localisation()
                        .remove_calculator_group_input_content,
                  ),
                )) ??
                false;
          },
          onDismissed: (_) => onDismissed?.call(),
          background: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.delete, color: Palette.red),
              )
            ],
          ),
          secondaryBackground: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.delete, color: Palette.red),
              )
            ],
          ),
          child: EntityLayout(
            repeatedIndex: repeatedIndex?.toString(),
            icon: mapEntityToIcon(entity.key),
            title: entity.title.tr(context),
            emissionValue: emissionValue,
            //TODO check with Emil how to get / store respective value for an entity
            isShared: false,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

class EntityLayout extends StatelessWidget {
  final String? repeatedIndex;
  final String? icon;
  final String title;
  final double? emissionValue;
  final bool isShared;
  final void Function() onPressed;

  const EntityLayout({
    Key? key,
    this.repeatedIndex,
    required this.icon,
    required this.title,
    this.emissionValue,
    this.isShared = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EntityCard(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              IconTheme(
                data: IconThemeData(
                    color:
                        // TODO what UI changes for shared entities to implement?
                        isShared ? Palette.secondary : Palette.primary,
                    size: 32),
                child: IconOnCircle(
                  icon: KlimoIcon(icon),
                ),
              ),
              const SizedBox(width: 8),
              if (repeatedIndex != null)
                Text(
                  '${repeatedIndex!}. ',
                  style: context.textTheme().labelLarge,
                ),
              Expanded(
                child: Text(
                  (isShared ? "Sharing - " : "") + title,
                  style: context.textTheme().labelLarge,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
              ),
              if (emissionValue != null) ...[
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/co2.svg',
                  height: 16,
                  color: Palette.red,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "${(emissionValue! * 1000).toStringAsFixed(0)} kg",
                    style: context.textTheme().labelLarge,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
