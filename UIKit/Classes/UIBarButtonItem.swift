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

public enum UIBarButtonSystemItem : Int {
    case Done
    case Cancel
    case Edit
    case Save
    case Add
    case FlexibleSpace
    case FixedSpace
    case Compose
    case Reply
    case Action
    case Organize
    case Bookmarks
    case Search
    case Refresh
    case Stop
    case Camera
    case Trash
    case Play
    case Pause
    case Rewind
    case FastForward
    case Undo
    // iPhoneOS 3.0
    case Redo
}

public enum UIBarButtonItemStyle : Int {
    case Plain
    case Bordered
    case Done
}

public class UIBarButtonItem: UIBarItem {
    var isSystemItem: Bool = false
    var systemItem: UIBarButtonSystemItem = .Done

    public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, target: AnyObject, action: Selector) {
		self.init()
		
		self.isSystemItem = true
		self.systemItem = systemItem
		self.target = target
		self.action = action
    }

    public convenience init(customView: UIView?) {
		self.init()
		
		_customView = customView
    }

    public convenience init(title: String, style: UIBarButtonItemStyle, target: AnyObject?, action: Selector) {
		self.init()
		
		self.title = title
		self.style = style
		self.target = target
		self.action = action
    }

    public convenience init(image: UIImage?, style: UIBarButtonItemStyle, target: AnyObject?, action: Selector) {
		self.init()
		
		self.image = image
		self.style = style
		self.target = target
		self.action = action
    }

    func backButtonBackgroundImageForState(state: UIControlState, barMetrics: UIBarMetrics) -> UIImage? {
        return nil
    }

    func setBackButtonBackgroundImage(backgroundImage: UIImage, forState state: UIControlState, barMetrics: UIBarMetrics) {
    }

    func backButtonTitlePositionAdjustmentForBarMetrics(barMetrics: UIBarMetrics) -> UIOffset {
        return .zero
    }

    func setBackButtonTitlePositionAdjustment(adjustment: UIOffset, forBarMetrics barMetrics: UIBarMetrics) {
    }

    func backButtonBackgroundVerticalPositionAdjustmentForBarMetrics(barMetrics: UIBarMetrics) -> CGFloat {
        return 0
    }

    func setBackButtonBackgroundVerticalPositionAdjustment(adjustment: CGFloat, forBarMetrics barMetrics: UIBarMetrics) {
    }

    func backgroundVerticalPositionAdjustmentForBarMetrics(barMetrics: UIBarMetrics) -> CGFloat {
        return 0
    }

    func setBackgroundVerticalPositionAdjustment(adjustment: CGFloat, forBarMetrics barMetrics: UIBarMetrics) {
    }

    func backgroundImageForState(state: UIControlState, barMetrics: UIBarMetrics) -> UIImage? {
        return nil
    }

    func setBackgroundImage(backgroundImage: UIImage, forState state: UIControlState, barMetrics: UIBarMetrics) {
    }

    func backgroundImageForState(state: UIControlState, style: UIBarButtonItemStyle, barMetrics: UIBarMetrics) -> UIImage? {
        return nil
    }

    func setBackgroundImage(backgroundImage: UIImage, forState state: UIControlState, style: UIBarButtonItemStyle, barMetrics: UIBarMetrics) {
    }

    func titlePositionAdjustmentForBarMetrics(barMetrics: UIBarMetrics) -> UIOffset {
        return UIOffsetZero
    }

    func setTitlePositionAdjustment(adjustment: UIOffset, forBarMetrics barMetrics: UIBarMetrics) {
    }
    var style: UIBarButtonItemStyle
    var width: CGFloat
	private var _customView: UIView?
    var customView: UIView? {
        get {
            return isSystemItem ? nil : _customView
        }
    }

    public var target: AnyObject?
    public var action: Selector
    public var tintColor: UIColor?

	public override init() {
		self.isSystemItem = false
		self.style = .Plain
		super.init()
    }
}
