import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12 // без него не будет работать механизм layout
import QtQuick.Controls.Material 2.3
import QtQuick.Dialogs 1.2 // для "открыть видео" во 2 лабе, пока не реализовано
import QtQuick.Controls.Styles 1.4 // можно менять стили кнопки, но в итоге пока не используется
import QtQuick.Window 2.12
import QtQml 2.12
import QtWebView 1.15
import QtWebSockets 1.1

Page {
    id:page6GUI
    background: Rectangle{
        color: "darkgrey"}
    header: Rectangle {
        id: header
        color: "#ff0000"
        y: 0
        height: 45

        Label {
            color: "white"
            text: "Lab 6"
            font.weight: "DemiBold"
            font.pixelSize: 15
            anchors.verticalCenter: parent.verticalCenter
            x: 4
        }
        Rectangle{ //нижняя граница заголовка
            height: 3
            color: "black"
            anchors.top: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
        }
        Image {
            id: refresh
            source: "images/reload.png"
            anchors.right: search.left
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 25
            height: 25
        }
        Image {
            id: search
            source: "images/search.png"
            anchors.right: create.left
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 25
            height: 25
        }
        Image {
            id: create
            source: "images/light-bulb.png"
            anchors.right: more.left
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            width: 25
            height: 25
        }
        Image {
            id: more
            source: "images/menu.png"
            anchors.right: parent.right
            //anchors.left: create.right
            anchors.rightMargin: 3
            anchors.verticalCenter: parent.verticalCenter
            width: 25
            height: 25
        }
    }
    GridLayout{
        anchors.fill:parent
        anchors.margins: 10
        columns:2
        rows: 3

            TextField{
                Layout.column: 1
                Layout.row: 0
                id: inFile
                Layout.fillWidth: parent
                placeholderText: qsTr("File name")
                Layout.alignment: Qt.AlignCenter
                font.family: "Helvetica"
            }
            Button {
                Layout.column: 1
                Layout.row: 1
                id: btnfordialoglab7
                text: qsTr("Выбрать файл")
                Layout.alignment: Qt.AlignCenter
                onClicked: fileDialoglab7.open()
                FileDialog {
                    folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                    id: fileDialoglab7
                    title: "Please choose a file"
                    nameFilters: [ "Text files (*.txt)", "All files (*.*)"]
                    onAccepted: {
                        inFile.text = decodeURIComponent(fileDialoglab7.fileUrl)
                    }
                }

                contentItem: Text {
                    text: btnfordialoglab7.text
                    font: btnfordialoglab7.font
                    opacity: enabled ? 1.0 : 0.3
                    color: btnfordialoglab7.down ? "#ff0000" : "pink"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    border.color: btnfordialoglab7.down ? "black" : "#ff0000"
                    border.width: 1
                    radius: 2
                }
            }

        TextField{
            id: keytext
            Layout.column: 1
            Layout.row: 2
            Layout.columnSpan: 2
            Layout.fillWidth: parent
            placeholderText: qsTr("Key")
            Layout.alignment: Qt.AlignCenter
            font.family: "Arial"
            font.pixelSize: 15
            anchors.bottomMargin: 40
            maximumLength: 32
        }


        Button{
            Layout.column: 0
            Layout.row: 3
            id: encrbtn
            Layout.alignment: Qt.AlignCenter
            text: "Зашифровать"

            visible: if(fileDialoglab7.fileUrl === 0)
                         false
                     else
                         true
            onClicked: {cryptocontroller.encriptFile(keytext, fileDialoglab7.fileUrls)
                        if (cryptocontroller.encriptFile(keytext, fileDialoglab7.fileUrls) === true){
                         encrbtn.Material.background = "#a8f25e"
                         decrbtn.Material.background = "#4cc382"
                        }
            }

            contentItem: Text {
                text: encrbtn.text
                font: encrbtn.font
                opacity: enabled ? 1.0 : 0.3
                color: encrbtn.down ? "#ff0000" : "black"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.color: encrbtn.down ? "black" : "#ff0000"
                border.width: 1
                radius: 2
            }

        }

        Button{
            Layout.column: 2
            Layout.row: 3
            id: decrbtn
            Layout.alignment: Qt.AlignCenter
            text: "Расшифровать"
            visible: if(fileDialoglab7.fileUrl === 0)
                         false
                     else
                         true
            onClicked: {cryptocontroller.decriptFile(keytext, fileDialoglab7.fileUrls)
                        if (cryptocontroller.decriptFile(keytext, fileDialoglab7.fileUrls) === true){
                            encrbtn.Material.background = "#4cc382"
                            decrbtn.Material.background = "#a8f25e"
                        }

            }
            contentItem: Text {
                text: decrbtn.text
                font: decrbtn.font
                opacity: enabled ? 1.0 : 0.3
                color: decrbtn.down ? "#ff0000" : "black"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.color: decrbtn.down ? "black" : "#ff0000"
                border.width: 1
                radius: 2
            }
        }

}


}

