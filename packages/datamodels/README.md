# klimo / datamodels

This package contains files related to the calculation, input and challenge models.

## Workflow

The models use the `built_value` package. To build the generated parts run: (make sure, that you `cd`ed into the `datamodels` folder)

```bash
$ dart run build_runner build
```

To automatically regenerate on file changes run `build_runner` in watch-mode:

```bash
$ dart run build_runner watch
```
