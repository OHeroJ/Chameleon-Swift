/*
 * Copyright (c) 2011, The Iconfactory. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of The Iconfactory nor the names of its contributors may
 *    be used to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE ICONFACTORY BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
import Foundation
public enum UITouchPhase : Int {
    case Began
    case Moved
    case Stationary
    case Ended
    case Cancelled
}

public class UITouch: NSObject {
    func locationInView(inView: UIView) -> CGPoint {
        return self.window.convertPoint(self.window.convertPoint(locationOnScreen, fromWindow: nil), toView: inView)
    }

    func previousLocationInView(inView: UIView) -> CGPoint {
        return self.window.convertPoint(self.window.convertPoint(previousLocationOnScreen, fromWindow: nil), toView: inView)
    }
    var timestamp: NSTimeInterval {
        didSet {
            if phase == .Began {
                self.beganPhaseTimestamp = timestamp
            }
        }
    }

    var tapCount: Int

    var phase: UITouchPhase {
        didSet {
            if phase == .Stationary || phase == .Began {
                self.previousLocationOnScreen = locationOnScreen
            }
        }
    }

    var view: UIView? {
		didSet {
			window = view?.window
		}
    }

    var window: UIWindow!

	var locationOnScreen: CGPoint {
		willSet {
			self.previousLocationOnScreen = locationOnScreen
		}
		didSet(locationOnScreen) {
			if phase == .Stationary || phase == .Began {
				self.previousLocationOnScreen = locationOnScreen
			}
			if phase == .Began {
				self.beganPhaseLocationOnScreen = locationOnScreen
			}

		}
	}
    var previousLocationOnScreen: CGPoint
    var gestureRecognizers: [UIGestureRecognizer]
    var wasDeliveredToView: Bool
    var wasCancelledInView: Bool
    var beganPhaseTimestamp: NSTimeInterval
    var beganPhaseLocationOnScreen: CGPoint


	override init() {
            self.phase = .Began
            self.timestamp = NSDate.timeIntervalSinceReferenceDate()
            self.gestureRecognizers = [AnyObject]()
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "_viewDidMoveToSuperviewNotification:", name: UIViewDidMoveToSuperviewNotification, object: nil)
		super.init()
	}

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIViewDidMoveToSuperviewNotification, object: nil)
    }

    func _viewDidMoveToSuperviewNotification(notification: NSNotification) {
        if view?.isDescendantOfView(notification.object as? UIView) ?? false {
            self.view = nil
        }
    }

    func _addGestureRecognizer(gesture: UIGestureRecognizer) {
        gestureRecognizers.append(gesture)
    }

    func _removeGestureRecognizer(gesture: UIGestureRecognizer) {
        gestureRecognizers.removeObject(gesture)
    }

    override public var description: String {
        var phase: String = ""
        switch self.phase {
            case .Began:
                phase = "Began"
            case .Moved:
                phase = "Moved"
            case .Stationary:
                phase = "Stationary"
            case .Ended:
                phase = "Ended"
            case .Cancelled:
                phase = "Cancelled"
        }

        return "<\(self.className): \(unsafeAddressOf(self)); timestamp = \(self.timestamp); tapCount = \(UInt(self.tapCount)); phase = \(phase); view = \(self.view!); window = \(self.window)>"
    }
}