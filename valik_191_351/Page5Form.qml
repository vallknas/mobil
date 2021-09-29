import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtMultimedia 5.4
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.12
//import QtWebView 1.15
import QtQml 2.12
import QtWebSockets 1.1

Page {
    id:page4
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
                text: qsTr("Лабораторная работа №5")
                color: "black"
                font.family: "Helvetica"; font.pointSize: 13; font.bold: true
                anchors.leftMargin: 3
                Layout.alignment: Qt.AlignLeft
            }
        }

    }


}
