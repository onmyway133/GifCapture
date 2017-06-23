import AppKit

class MainWindowController: NSWindowController, NSWindowDelegate {

  let key = "GifCaptureFrameKey"

  override func windowDidLoad() {
    super.windowDidLoad()

    NotificationCenter.default.addObserver(self, selector: #selector(windowWillClose(_:)), name: Notification.Name.NSWindowWillClose, object: nil)
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    guard let data = UserDefaults.standard.data(forKey: key),
      let frame = NSKeyedUnarchiver.unarchiveObject(with: data) as? NSRect else {
        return
    }

    window?.setFrame(frame, display: true)
  }

  func windowWillClose(_ notification: Notification) {
    guard let frame = window?.frame else {
      return
    }

    let data = NSKeyedArchiver.archivedData(withRootObject: frame)
    UserDefaults.standard.set(data, forKey: key)
  }
}
