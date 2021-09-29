import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12 //для настройки стиля Material
import QtWebSockets 1.15


Page { // ЛР 7. Простейший чат-сервер на WebSocket.

    ListModel { //модель для ListView
        id: listmodel1
    }

    header: Rectangle {
        id: header
        color: "#ff0000"
        y: 0
        height: 45

        Label {
            color: "white"
            text: "Lab 7: WebSockets."
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

    WebSocket{
        id: websocket_1
        url: ""
        active: true
        onTextMessageReceived: {
//            console.log(message)
            let list_el = {}
            list_el["msg_text"] = message
            list_el["is_out"] = false
            list_el["msg_date"] = String(Qt.formatDateTime(new Date(), "dd MMMM yyyy, h:mm"))
            listmodel1.insert(0, list_el)
        }

        onStatusChanged: if (websocket_1.status == WebSocket.Error) {
                             console.log("Error: " + websocket_1.errorString)
                         } else if (websocket_1.status == WebSocket.Open) {
                             console.log("opened")
                         } else if (websocket_1.status == WebSocket.Closed) {
                             console.log("socket closed")
                         }
    }

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 5

        ListView{
            id: listview1
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 5
            spacing: 10
            clip: true
            model: listmodel1
            verticalLayoutDirection: ListView.BottomToTop

            delegate: Item {
                width: listview1.width
                height: brd_img.height

                Image {
                    id: brd_img
                    width: parent.width * 3/4
                    height: txtMessage.contentHeight  + 40 + txtDate.contentHeight
                    source: is_out ? "img/balloon_out.png" : "img/balloon_in.png"
                    anchors.left: is_out ? undefined : parent.left
                    anchors.right: is_out ? parent.right : undefined

                    ColumnLayout{
                        anchors.fill: parent
                        anchors.topMargin: 15
                        anchors.bottomMargin: 10
                        anchors.leftMargin: 25
                        anchors.rightMargin: 25
                        TextEdit{ // текст сообщения
                            id: txtMessage
                            text: msg_text
                            font.pixelSize: 13
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            wrapMode: Text.Wrap
                            readOnly: true
                        }
                        TextEdit{
                            id: txtDate
                            text: msg_date
                            font.italic: true
                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignRight
                            wrapMode: Text.Wrap
                            readOnly: true
                        }
                    }
                }
            }
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.fillHeight: false
            Layout.alignment: Qt.AlignBottom
            Layout.topMargin: 0
            TextField{
                id: out_msg_text
                Layout.fillWidth: true
                color: "white"
            }
            Button{
                onClicked: {
                    if(out_msg_text.text) {
                        let list_el = {}
                        list_el["msg_text"] = out_msg_text.text
                        list_el["is_out"] = true
                        list_el["msg_date"] = Qt.formatDateTime(new Date(), "dd MMMM yyyy, h:mm")
                        listmodel1.insert(0, list_el)
                        websocket_1.sendTextMessage(out_msg_text.text)
                        out_msg_text.text = ""
                    }
                }
                icon.source: "images/paper-plane.png"
                icon.color: "black"
            }
        }
    }

}
