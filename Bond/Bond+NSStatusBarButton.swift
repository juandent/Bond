//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Tony Arnold (@tonyarnold)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Cocoa

var appearsDisabledDynamicHandleNSStatusBarButton: UInt8 = 0;

extension NSStatusBarButton {

    public var dynAppearsDisabled: Dynamic<Bool> {
        if let d: AnyObject = objc_getAssociatedObject(self, &appearsDisabledDynamicHandleNSStatusBarButton) {
            return (d as? Dynamic<Bool>)!
        } else {
            let d = InternalDynamic<Bool>(self.appearsDisabled)
            let bond = Bond<Bool>() { [weak self] v in
                if let s = self {
                    s.appearsDisabled = v
                }
            }

            d.bindTo(bond, fire: false, strongly: false)
            d.retain(bond)
            objc_setAssociatedObject(self, &appearsDisabledDynamicHandleNSStatusBarButton, d, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
            return d
        }
    }
    
}