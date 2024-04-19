import 'package:flutter/material.dart';
import 'package:klimo/utils/theme.dart';

class ProjectCard extends StatelessWidget {
  final Widget? headerImage;
  final String? title;
  final String? subtitle;
  final VoidCallback? onClick;

  const ProjectCard({
    Key? key,
    this.headerImage,
    this.title,
    this.subtitle,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 100,
              child: Stack(
                children: [
                  if (headerImage != null)
                    Positioned.fill(
                      child: headerImage!,
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  if (title != null)
                    Positioned(
                      bottom: 4.0,
                      left: 8.0,
                      right: 8.0,
                      child: Text(
                        title!,
                        style: context
                            .textTheme()
                            .headlineMedium
                            ?.copyWith(color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            if (subtitle != null)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    8.0,
                    8.0,
                    16.0,
                    16.0,
                  ),
                  child: Text(
                    subtitle!,
                    style: context.textTheme().bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
