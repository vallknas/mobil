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
    header : ToolBar{
        background: Rectangle {
            id:rec2
            color: "#ff0000"}
        GridLayout{
            id:layout1
            anchors.fill:parent
            columns:2
            rows: 1
            Label {
                id: lab1
                text: qsTr("Лабораторная работа №3")
                color: "black"
                font.family: "Helvetica"; font.pointSize: 13; font.bold: true
                anchors.leftMargin: 3
                Layout.alignment: Qt.AlignLeft
            }
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
