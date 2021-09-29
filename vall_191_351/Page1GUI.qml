import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.14
import QtMultimedia 5.14
import QtQuick.Dialogs 1.3

Page{
    id:page3
    background: Rectangle{
        color: "darkgrey"}
    header: Rectangle {
        id: header
        color: "#ff0000"
        y: 0
        height: 45

        Label {
            color: "white"
            text: "Lab 3"
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
        //иконки
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
            width: 23
            height: 23
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
    GridLayout {
        anchors.fill: parent
        columns: 2

        ScrollView {
            Layout.fillHeight: true
            Layout.columnSpan: 2
            Layout.fillWidth: true
            clip:  true
            TextArea {
                id: textArea
                textFormat: Text.PlainText
                objectName: "textArea"
                readOnly: true
                anchors.fill: parent
                background: Rectangle {
                    color: "grey"
                }
            }
        }
        Button {
            id: send
            Layout.alignment: Qt.AlignCenter
            Layout.columnSpan: 2
            text: qsTr("Запросить информацию")
            font.family: "Helvetica"; font.pointSize: 13;
            onClicked: {
                _send.getNetworkValue();
            }

        }


        RowLayout{
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignCenter
            Label {
                text: "Курс доллара на"
            }
            Label {
                id:curdate
                objectName: "curdate"
            }
        }
        RowLayout{
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignCenter

            TextField {
                id: textField
                objectName: "textField"
                horizontalAlignment: Text.AlignHCenter
                readOnly: true
                Layout.alignment: Qt.AlignCenter
                Layout.columnSpan: 2
            }


            TextField {
                id: textFieldDate
                objectName: "textFieldDate"
                readOnly: true
                Layout.alignment: Qt.AlignCenter
                Layout.columnSpan: 2

            }

        }

    }
}
