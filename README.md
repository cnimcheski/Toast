# Toasts
All toasts are managed by the ToastManager.

## Creating a new toast
All
To create a new toast, simply add a case to `ToastType`.

## Presenting a toast
The `ToastManager` object is a FactoryKit singleton so it's injectable within any other object:
```
final class ExampleViewModel: ViewModel {
    @Injected(\.toastManager) private var toastManager

    ...

    @MainActor
    func exampleMethod() {
        toastManager.push(.offline)
    }
}
```

## Testing toast presentation
We can use the Previews to test toast presentation. If needing to test on simulator or physical device, replace the following line within `ToastCoordinatorViewModel`:
```
let rootController = UIHostingController(rootView: ToastView())
```
With:
```
let rootController = UIHostingController(rootView: ToastView(viewModel: PreviewToastViewModel()))
```

This will automatically present and dismiss a 5 second toast. The toast will continue on a presentation loop so things like the close button behavior can be tested.

**Make sure these changes are never pushed to production!**
