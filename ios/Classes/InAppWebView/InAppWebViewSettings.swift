//
//  InAppWebViewSettings.swift
//  flutter_inappwebview
//
//  Created by Lorenzo on 21/10/18.
//

import Foundation
import WebKit

@objcMembers
public class InAppWebViewSettings: ISettings<InAppWebView> {
    
    var useShouldOverrideUrlLoading = false
    var useOnLoadResource = false
    var useOnDownloadStart = false
    var clearCache = false
    var userAgent = ""
    var applicationNameForUserAgent = ""
    var javaScriptEnabled = true
    var javaScriptCanOpenWindowsAutomatically = false
    var mediaPlaybackRequiresUserGesture = true
    var verticalScrollBarEnabled = true
    var horizontalScrollBarEnabled = true
    var resourceCustomSchemes: [String] = []
    var contentBlockers: [[String: [String : Any]]] = []
    var minimumFontSize = 0
    var useShouldInterceptAjaxRequest = false
    var useShouldInterceptFetchRequest = false
    var incognito = false
    var cacheEnabled = true
    var transparentBackground = false
    var disableVerticalScroll = false
    var disableHorizontalScroll = false
    var disableContextMenu = false
    var supportZoom = true
    var allowUniversalAccessFromFileURLs = false
    var allowFileAccessFromFileURLs = false

    var disallowOverScroll = false
    var enableViewportScale = false
    var suppressesIncrementalRendering = false
    var allowsAirPlayForMediaPlayback = true
    var allowsBackForwardNavigationGestures = true
    var allowsLinkPreview = true
    var ignoresViewportScaleLimits = false
    var allowsInlineMediaPlayback = false
    var allowsPictureInPictureMediaPlayback = true
    var isFraudulentWebsiteWarningEnabled = true;
    var selectionGranularity = 0;
    var dataDetectorTypes: [String] = ["NONE"] // WKDataDetectorTypeNone
    var preferredContentMode = 0
    var sharedCookiesEnabled = false
    var automaticallyAdjustsScrollIndicatorInsets = false
    var accessibilityIgnoresInvertColors = false
    var decelerationRate = "NORMAL" // UIScrollView.DecelerationRate.normal
    var alwaysBounceVertical = false
    var alwaysBounceHorizontal = false
    var scrollsToTop = true
    var isPagingEnabled = false
    var maximumZoomScale = 1.0
    var minimumZoomScale = 1.0
    var contentInsetAdjustmentBehavior = 2 // UIScrollView.ContentInsetAdjustmentBehavior.never
    var isDirectionalLockEnabled = false
    var mediaType: String? = nil
    var pageZoom = 1.0
    var limitsNavigationsToAppBoundDomains = false
    var useOnNavigationResponse = false
    var applePayAPIEnabled = false
    var allowingReadAccessTo: String? = nil
    var disableLongPressContextMenuOnLinks = false
    var disableInputAccessoryView = false
    var underPageBackgroundColor: String?
    var isTextInteractionEnabled = true
    var isSiteSpecificQuirksModeEnabled = true
    var upgradeKnownHostsToHTTPS = true
    
    override init(){
        super.init()
    }
    
    override func parse(settings: [String: Any?]) -> InAppWebViewSettings {
        let _ = super.parse(settings: settings)
        if #available(iOS 13.0, *) {} else {
            applePayAPIEnabled = false
        }
        return self
    }
    
    override func getRealSettings(obj: InAppWebView?) -> [String: Any?] {
        var realSettings: [String: Any?] = toMap()
        if let webView = obj {
            let configuration = webView.configuration
            if #available(iOS 9.0, *) {
                realSettings["userAgent"] = webView.customUserAgent
                realSettings["applicationNameForUserAgent"] = configuration.applicationNameForUserAgent
                realSettings["allowsAirPlayForMediaPlayback"] = configuration.allowsAirPlayForMediaPlayback
                realSettings["allowsLinkPreview"] = webView.allowsLinkPreview
                realSettings["allowsPictureInPictureMediaPlayback"] = configuration.allowsPictureInPictureMediaPlayback
            }
            realSettings["javaScriptCanOpenWindowsAutomatically"] = configuration.preferences.javaScriptCanOpenWindowsAutomatically
            if #available(iOS 10.0, *) {
                realSettings["mediaPlaybackRequiresUserGesture"] = configuration.mediaTypesRequiringUserActionForPlayback == .all
                realSettings["ignoresViewportScaleLimits"] = configuration.ignoresViewportScaleLimits
                realSettings["dataDetectorTypes"] = Util.getDataDetectorTypeString(type: configuration.dataDetectorTypes)
            } else {
                realSettings["mediaPlaybackRequiresUserGesture"] = configuration.mediaPlaybackRequiresUserAction
            }
            realSettings["minimumFontSize"] = configuration.preferences.minimumFontSize
            realSettings["suppressesIncrementalRendering"] = configuration.suppressesIncrementalRendering
            realSettings["allowsBackForwardNavigationGestures"] = webView.allowsBackForwardNavigationGestures
            realSettings["allowsInlineMediaPlayback"] = configuration.allowsInlineMediaPlayback
            if #available(iOS 13.0, *) {
                realSettings["isFraudulentWebsiteWarningEnabled"] = configuration.preferences.isFraudulentWebsiteWarningEnabled
                realSettings["preferredContentMode"] = configuration.defaultWebpagePreferences.preferredContentMode.rawValue
                realSettings["automaticallyAdjustsScrollIndicatorInsets"] = webView.scrollView.automaticallyAdjustsScrollIndicatorInsets
            }
            realSettings["selectionGranularity"] = configuration.selectionGranularity.rawValue
            if #available(iOS 11.0, *) {
                realSettings["accessibilityIgnoresInvertColors"] = webView.accessibilityIgnoresInvertColors
                realSettings["contentInsetAdjustmentBehavior"] = webView.scrollView.contentInsetAdjustmentBehavior.rawValue
            }
            realSettings["decelerationRate"] = Util.getDecelerationRateString(type: webView.scrollView.decelerationRate)
            realSettings["alwaysBounceVertical"] = webView.scrollView.alwaysBounceVertical
            realSettings["alwaysBounceHorizontal"] = webView.scrollView.alwaysBounceHorizontal
            realSettings["scrollsToTop"] = webView.scrollView.scrollsToTop
            realSettings["isPagingEnabled"] = webView.scrollView.isPagingEnabled
            realSettings["maximumZoomScale"] = webView.scrollView.maximumZoomScale
            realSettings["minimumZoomScale"] = webView.scrollView.minimumZoomScale
            realSettings["allowUniversalAccessFromFileURLs"] = configuration.value(forKey: "allowUniversalAccessFromFileURLs")
            realSettings["allowFileAccessFromFileURLs"] = configuration.preferences.value(forKey: "allowFileAccessFromFileURLs")
            realSettings["isDirectionalLockEnabled"] = webView.scrollView.isDirectionalLockEnabled
            realSettings["javaScriptEnabled"] = configuration.preferences.javaScriptEnabled
            if #available(iOS 14.0, *) {
                realSettings["mediaType"] = webView.mediaType
                realSettings["pageZoom"] = Float(webView.pageZoom)
                realSettings["limitsNavigationsToAppBoundDomains"] = configuration.limitsNavigationsToAppBoundDomains
                realSettings["javaScriptEnabled"] = configuration.defaultWebpagePreferences.allowsContentJavaScript
            }
            if #available(iOS 14.5, *) {
                realSettings["isTextInteractionEnabled"] = configuration.preferences.isTextInteractionEnabled
                realSettings["upgradeKnownHostsToHTTPS"] = configuration.upgradeKnownHostsToHTTPS
            }
            if #available(iOS 15.0, *) {
                realSettings["underPageBackgroundColor"] = webView.underPageBackgroundColor.hexString
                if configuration.preferences.responds(to: #selector(getter: self.isSiteSpecificQuirksModeEnabled)) {
                    realSettings["isSiteSpecificQuirksModeEnabled"] = configuration.preferences.isSiteSpecificQuirksModeEnabled
                }
            }
        }
        return realSettings
    }
}