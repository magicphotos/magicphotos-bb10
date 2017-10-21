import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import ImageEditor 1.0

import "../Util.js" as UtilScript

Page {
    id: cartoonPage

    header: Pane {
        topPadding: cartoonPage.bannerHeight

        Material.background: Material.LightBlue

        ButtonGroup {
            buttons: headerRow.children
        }

        Row {
            id:               headerRow
            anchors.centerIn: parent

            Button {
                id:        scrollModeButton
                width:     UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)
                height:    UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)
                enabled:   false
                checkable: true
                checked:   true

                contentItem: Image {
                    source:   "qrc:/resources/images/mode_scroll.png"
                    fillMode: Image.PreserveAspectFit
                }

                onCheckedChanged: {
                    if (checked) {
                        cartoonEditor.mode          = CartoonEditor.ModeScroll;
                        editorFlickable.interactive = true;
                        editorPinchArea.enabled     = true;
                    }
                }
            }

            Button {
                id:        originalModeButton
                width:     UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)
                height:    UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)
                enabled:   false
                checkable: true

                contentItem: Image {
                    source:   "qrc:/resources/images/mode_original.png"
                    fillMode: Image.PreserveAspectFit
                }

                onCheckedChanged: {
                    if (checked) {
                        cartoonEditor.mode          = CartoonEditor.ModeOriginal;
                        editorFlickable.interactive = false;
                        editorPinchArea.enabled     = false;
                    }
                }
            }

            Button {
                id:        effectedModeButton
                width:     UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)
                height:    UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)
                enabled:   false
                checkable: true

                contentItem: Image {
                    source:   "qrc:/resources/images/mode_effected.png"
                    fillMode: Image.PreserveAspectFit
                }

                onCheckedChanged: {
                    if (checked) {
                        cartoonEditor.mode          = CartoonEditor.ModeEffected;
                        editorFlickable.interactive = false;
                        editorPinchArea.enabled     = false;
                    }
                }
            }
        }
    }

    footer: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                id:             saveToolButton
                implicitWidth:  UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)
                implicitHeight: UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)
                enabled:        false

                contentItem: Image {
                    source:   "qrc:/resources/images/tool_save.png"
                    fillMode: Image.PreserveAspectFit
                }

                onClicked: {
                    if (mainWindow.fullVersion) {
                        var date  = new Date();
                        var year  = date.getFullYear();
                        var month = date.getMonth() + 1;
                        var day   = date.getDate();
                        var hour  = date.getHours();
                        var min   = date.getMinutes();
                        var sec   = date.getSeconds();

                        var file_name = "IMG_" + year                              + "-" +
                                                 (month > 9 ? month : "0" + month) + "-" +
                                                 (day   > 9 ? day   : "0" + day)   + "_" +
                                                 (hour  > 9 ? hour  : "0" + hour)  + "-" +
                                                 (min   > 9 ? min   : "0" + min)   + "-" +
                                                 (sec   > 9 ? sec   : "0" + sec)   + ".jpg";

                        cartoonPage.shareActionActive = false;

                        cartoonEditor.saveImage(AndroidGW.getSaveDirectory() + "/" + file_name);
                    } else {
                        purchaseMessageDialog.open();
                    }
                }
            }

            ToolButton {
                id:             shareToolButton
                implicitWidth:  UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)
                implicitHeight: UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)
                enabled:        false

                contentItem: Image {
                    source:   "qrc:/resources/images/tool_share.png"
                    fillMode: Image.PreserveAspectFit
                }

                onClicked: {
                    if (mainWindow.fullVersion) {
                        var date  = new Date();
                        var year  = date.getFullYear();
                        var month = date.getMonth() + 1;
                        var day   = date.getDate();
                        var hour  = date.getHours();
                        var min   = date.getMinutes();
                        var sec   = date.getSeconds();

                        var file_name = "IMG_" + year                              + "-" +
                                                 (month > 9 ? month : "0" + month) + "-" +
                                                 (day   > 9 ? day   : "0" + day)   + "_" +
                                                 (hour  > 9 ? hour  : "0" + hour)  + "-" +
                                                 (min   > 9 ? min   : "0" + min)   + "-" +
                                                 (sec   > 9 ? sec   : "0" + sec)   + ".jpg";

                        cartoonPage.shareActionActive = true;

                        cartoonEditor.saveImage(AndroidGW.getSaveDirectory() + "/" + file_name);
                    } else {
                        purchaseMessageDialog.open();
                    }
                }
            }

            ToolButton {
                id:             undoToolButton
                implicitWidth:  UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)
                implicitHeight: UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)
                enabled:        false

                contentItem: Image {
                    source:   "qrc:/resources/images/tool_undo.png"
                    fillMode: Image.PreserveAspectFit
                }

                onClicked: {
                    cartoonEditor.undo();
                }
            }

            ToolButton {
                implicitWidth:  UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)
                implicitHeight: UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)

                contentItem: Image {
                    source:   "qrc:/resources/images/tool_settings.png"
                    fillMode: Image.PreserveAspectFit
                }

                onClicked: {
                    brushSettingsPane.visible = !brushSettingsPane.visible;
                }
            }

            ToolButton {
                implicitWidth:  UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)
                implicitHeight: UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 48)

                contentItem: Image {
                    source:   "qrc:/resources/images/tool_help.png"
                    fillMode: Image.PreserveAspectFit
                }

                onClicked: {
                    Qt.openUrlExternally(qsTr("http://magicphotos.sourceforge.net/help/android/help.html"));
                }
            }
        }
    }

    property bool   shareActionActive: false

    property int    bannerHeight:      0
    property int    imageOrientation:  -1
    property int    gaussianRadius:    -1
    property int    cartoonThreshold:  -1

    property string imageFile:         ""

    function updateEditorParameters() {
        cartoonEditor.brushSize    = AppSettings.brushSize;
        cartoonEditor.brushOpacity = AppSettings.brushOpacity;
    }

    Component.onCompleted: {
        cartoonEditor.helperImageReady.connect(helper.helperImageReady);

        updateEditorParameters();
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            if (brushSettingsPane.visible) {
                brushSettingsPane.visible = false;
            } else if (cartoonEditor.changed) {
                backMessageDialog.open();
            } else {
                mainStackView.pop();
            }

            event.accepted = true;
        }
    }

    onImageOrientationChanged: {
        if (imageOrientation !== -1 && gaussianRadius !== -1 && cartoonThreshold !== -1 && imageFile !== "") {
            cartoonEditor.radius    = gaussianRadius;
            cartoonEditor.threshold = cartoonThreshold;

            cartoonEditor.openImage(imageFile, imageOrientation);
        }
    }

    onGaussianRadiusChanged: {
        if (imageOrientation !== -1 && gaussianRadius !== -1 && cartoonThreshold !== -1 && imageFile !== "") {
            cartoonEditor.radius    = gaussianRadius;
            cartoonEditor.threshold = cartoonThreshold;

            cartoonEditor.openImage(imageFile, imageOrientation);
        }
    }

    onCartoonThresholdChanged: {
        if (imageOrientation !== -1 && gaussianRadius !== -1 && cartoonThreshold !== -1 && imageFile !== "") {
            cartoonEditor.radius    = gaussianRadius;
            cartoonEditor.threshold = cartoonThreshold;

            cartoonEditor.openImage(imageFile, imageOrientation);
        }
    }

    onImageFileChanged: {
        if (imageOrientation !== -1 && gaussianRadius !== -1 && cartoonThreshold !== -1 && imageFile !== "") {
            cartoonEditor.radius    = gaussianRadius;
            cartoonEditor.threshold = cartoonThreshold;

            cartoonEditor.openImage(imageFile, imageOrientation);
        }
    }

    Rectangle {
        id:           editorRectangle
        anchors.fill: parent
        color:        "transparent"

        Flickable {
            id:             editorFlickable
            anchors.fill:   parent
            boundsBehavior: Flickable.StopAtBounds

            property real initialContentWidth:  0.0
            property real initialContentHeight: 0.0

            PinchArea {
                id:             editorPinchArea
                anchors.fill:   parent
                pinch.dragAxis: Pinch.NoDrag

                onPinchUpdated: {
                    if (editorFlickable.initialContentWidth > 0.0) {
                        editorFlickable.contentX += pinch.previousCenter.x - pinch.center.x;
                        editorFlickable.contentY += pinch.previousCenter.y - pinch.center.y;

                        var scale = 1.0 + pinch.scale - pinch.previousScale;

                        if (editorFlickable.contentWidth * scale / editorFlickable.initialContentWidth >= 0.5 &&
                            editorFlickable.contentWidth * scale / editorFlickable.initialContentWidth <= 4.0) {
                            editorFlickable.resizeContent(editorFlickable.contentWidth * scale, editorFlickable.contentHeight * scale, pinch.center);
                        }
                    }
                }

                onPinchStarted: {
                    editorFlickable.interactive = false;
                }

                onPinchFinished: {
                    editorFlickable.interactive = true;

                    editorFlickable.returnToBounds();
                }

                CartoonEditor {
                    id:              cartoonEditor
                    scale:           editorFlickable.contentWidth        > 0.0 &&
                                     editorFlickable.initialContentWidth > 0.0 ?
                                     editorFlickable.contentWidth / editorFlickable.initialContentWidth : 1.0
                    transformOrigin: Item.TopLeft
                    helperSize:      helper.width

                    onImageOpened: {
                        waitRectangle.visible = false;

                        saveToolButton.enabled  = true;
                        shareToolButton.enabled = true;

                        scrollModeButton.enabled   = true;
                        originalModeButton.enabled = true;
                        effectedModeButton.enabled = true;

                        editorFlickable.contentWidth         = width;
                        editorFlickable.contentHeight        = height;
                        editorFlickable.initialContentWidth  = width;
                        editorFlickable.initialContentHeight = height;
                    }

                    onImageOpenFailed: {
                        waitRectangle.visible = false;

                        saveToolButton.enabled  = false;
                        shareToolButton.enabled = false;

                        scrollModeButton.enabled   = false;
                        originalModeButton.enabled = false;
                        effectedModeButton.enabled = false;

                        imageOpenFailedMessageDialog.open();
                    }

                    onImageSaved: {
                        AndroidGW.refreshGallery(image_file);

                        if (cartoonPage.shareActionActive) {
                            AndroidGW.shareImage(image_file);
                        } else {
                            imageSavedMessageDialog.open();
                        }
                    }

                    onImageSaveFailed: {
                        imageSaveFailedMessageDialog.open();
                    }

                    onUndoAvailabilityChanged: {
                        if (available) {
                            undoToolButton.enabled = true;
                        } else {
                            undoToolButton.enabled = false;
                        }
                    }

                    onMouseEvent: {
                        var rect = mapToItem(editorRectangle, x, y);

                        if (event_type === CartoonEditor.MousePressed) {
                            helperRectangle.visible = true;

                            if (rect.y < editorRectangle.height / 2) {
                                if (rect.x < editorRectangle.width / 2) {
                                    helperRectangle.anchors.left  = undefined;
                                    helperRectangle.anchors.right = editorRectangle.right;
                                } else {
                                    helperRectangle.anchors.right = undefined;
                                    helperRectangle.anchors.left  = editorRectangle.left;
                                }
                            }
                        } else if (event_type === CartoonEditor.MouseMoved) {
                            helperRectangle.visible = true;

                            if (rect.y < editorRectangle.height / 2) {
                                if (rect.x < editorRectangle.width / 2) {
                                    helperRectangle.anchors.left  = undefined;
                                    helperRectangle.anchors.right = editorRectangle.right;
                                } else {
                                    helperRectangle.anchors.right = undefined;
                                    helperRectangle.anchors.left  = editorRectangle.left;
                                }
                            }
                        } else if (event_type === CartoonEditor.MouseReleased) {
                            helperRectangle.visible = false;
                        }
                    }
                }
            }
        }

        Rectangle {
            id:           helperRectangle
            anchors.top:  parent.top
            anchors.left: parent.left
            width:        UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 128)
            height:       UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 128)
            z:            5
            visible:      false
            color:        "black"
            border.color: "white"
            border.width: UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 2)

            Helper {
                id:           helper
                anchors.fill: parent
            }
        }

        Rectangle {
            id:           waitRectangle
            anchors.fill: parent
            z:            10
            color:        "black"
            opacity:      0.75

            BusyIndicator {
                anchors.centerIn: parent
                running:          parent.visible
            }

            MouseArea {
                anchors.fill: parent
            }
        }
    }

    Pane {
        id:             brushSettingsPane
        anchors.bottom: parent.bottom
        anchors.left:   parent.left
        anchors.right:  parent.right
        z:              15
        visible:        false

        Material.elevation: 5

        onVisibleChanged: {
            if (visible) {
                brushSizeSlider.value    = AppSettings.brushSize;
                brushOpacitySlider.value = AppSettings.brushOpacity;
            }
        }

        GridLayout {
            anchors.fill:    parent
            anchors.margins: UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 4)
            rows:            2
            columns:         3
            rowSpacing:      UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 8)
            columnSpacing:   UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 4)

            BrushPreviewGenerator {
                id:      brushPreviewGenerator
                size:    brushSizeSlider.value
                maxSize: brushSizeSlider.to
                opacity: brushOpacitySlider.value

                Layout.rowSpan: 2
            }

            Slider {
                id:       brushSizeSlider
                from:     UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 8)
                to:       UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 24)
                value:    UtilScript.mapSizeToDevice(AndroidGW.getScreenDPI(), 16)
                stepSize: 1.0

                Layout.fillWidth: true

                onPressedChanged: {
                    if (!pressed) {
                        AppSettings.brushSize = value;

                        cartoonPage.updateEditorParameters();
                    }
                }
            }

            Label {
                id:             brushSizeLabel
                text:           qsTr("Brush Size")
                font.pointSize: 16
            }

            Slider {
                id:       brushOpacitySlider
                from:     0.0
                to:       1.0
                value:    0.75
                stepSize: 0.1

                Layout.fillWidth: true

                onPressedChanged: {
                    if (!pressed) {
                        AppSettings.brushOpacity = value;

                        cartoonPage.updateEditorParameters();
                    }
                }
            }

            Label {
                id:             brushOpacityLabel
                text:           qsTr("Brush Opacity")
                font.pointSize: 16
            }
        }
    }

    MessageDialog {
        id:              imageOpenFailedMessageDialog
        title:           qsTr("Error")
        icon:            StandardIcon.Critical
        text:            qsTr("Could not open image")
        standardButtons: StandardButton.Ok
    }

    MessageDialog {
        id:              imageSavedMessageDialog
        title:           qsTr("Info")
        icon:            StandardIcon.Information
        text:            qsTr("Image saved successfully")
        standardButtons: StandardButton.Ok
    }

    MessageDialog {
        id:              imageSaveFailedMessageDialog
        title:           qsTr("Error")
        icon:            StandardIcon.Critical
        text:            qsTr("Could not save image")
        standardButtons: StandardButton.Ok
    }

    MessageDialog {
        id:              backMessageDialog
        title:           qsTr("Warning")
        icon:            StandardIcon.Warning
        text:            qsTr("Are you sure? Current image is not saved and will be lost.")
        standardButtons: StandardButton.Yes | StandardButton.No

        onYes: {
            mainStackView.pop();
        }
    }

    MessageDialog {
        id:              purchaseMessageDialog
        title:           qsTr("Warning")
        icon:            StandardIcon.Warning
        text:            qsTr("This function is available in the full version only. Do you want to purchase full version now?")
        standardButtons: StandardButton.Yes | StandardButton.No

        onYes: {
            mainWindow.purchaseFullVersion();
        }
    }
}