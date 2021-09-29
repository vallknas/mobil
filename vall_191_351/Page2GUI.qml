import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtMultimedia 5.4
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.12
import QtWebView 1.15
import QtQml 2.12
import QtWebSockets 1.1

Page {
    id:page4
    background: Rectangle{
        color: "darkgrey"}
    header: Rectangle {
        id: header
        color: "#ff0000"
        y: 0
        height: 45

        Label {
            color: "white"
            text: "Lab 4"
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
    ColumnLayout{
        anchors.fill: parent
        Button {
            id: ant
            Layout.alignment: Qt.AlignCenter
            Layout.columnSpan: 2
            text:webView.visible==true? "Вернуться": "Авторизироваться через VK";
            font.family: "Helvetica"; font.pointSize: 13;
            onClicked: {
                webView.visible = webView.visible==true ? false: true;
            }
        }
        WebView{
            visible: false
            Layout.row: 2
            id: webView
            implicitHeight: 200
            implicitWidth: 400
            url: "https://oauth.vk.com/authorize?client_id=7902064&redirect_uri=&response_type=token&scope=0&v=5.92"
            Layout.fillWidth: true
            Layout.fillHeight: true
            onLoadingChanged: {
                success(webView.url)
                fail(webView.url)
                var token = webappcontroller.success(webView.url)
                var failtok = webappcontroller.fail(webView.url)
                if(token !== " "){
                    tokens.text = token
                    tokens.visible = token === " " ? false : true;
                    tok.visible = token === " " ? false : true;
                    webView.visible = token === " " ? true : false;
                    successtoken.visible = token === " " ? false : true;
                    mailbtn.visible = token === " " ? false : true;
                }
                else if (failtok === true){
                    webView.visible = failtok === false ? true : false;
                    failed.visible = failtok === false ? false : true;
                }
            }
        }

        RowLayout{
            id:tok
            visible: false
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignCenter
            Label {
                text: "Access token: "
            }
            Label{
                visible: false
                font.pixelSize: 9
                Layout.alignment: Qt.AlignCenter
                objectName: "TokenPokesh"
                id:tokens
            }
        }


        Label{
            visible: false
            Layout.row: 4
            Layout.alignment: Qt.AlignCenter
            id:failed
            font.pixelSize: 20
            text: "Ошибка при входе"
            color: "#ff0000"
            font.family: "Helvetica"; font.bold: true
        }

        Label{
            visible: false
            Layout.row: 4
            Layout.alignment: Qt.AlignCenter
            id:successtoken
            font.pixelSize: 20
            text: "Вы успешно авторизировались"
            color: "green"
            font.family: "Helvetica"; font.bold: true

        }

        Button {
            Layout.row: 5
            Layout.alignment: Qt.AlignCenter
            id: mailbtn
            text: qsTr("Список друзей")
            visible: false
            onClicked: {
                restRequest();
            }
            contentItem: Text {
                text: mailbtn.text
                font: mailbtn.font
                opacity: enabled ? 1.0 : 0.3
                color: mailbtn.down ? "#ff0000" : "pink"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                implicitWidth: 80
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.color: mailbtn.down ? "black" : "grey"
                border.width: 1
                radius: 2
            }
        }
    }

}
