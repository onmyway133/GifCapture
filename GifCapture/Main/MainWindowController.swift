import AppKit

class MainWindowController: NSWindowController {

  override func windowDidLoad() {
    super.windowDidLoad()

    shouldCascadeWindows = false
    windowFrameAutosaveName = "GifCaptureAutosave"
  }
}
