import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4

Page {
    id: page6crypto

    // Page backgroung.
    background: Rectangle {
        anchors.fill: parent
        color: "#fdfdfd"
    }

    header: ToolBar { //Заголовочный элемент, что содержит картинку, текст и прямоугольник
        contentHeight: 50
        anchors.top: parent.top

        background: Rectangle{
            color: "black"
        }

        Image { //Картинка для заголовка
            id: image1
            width: 40
            height: 40
            source: "WCW.png"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            layer.enabled: true
        }

        Rectangle { //Место для картинки и текста
            id: mask
            width: 36
            height: 36
            //radius: 18
            visible: false
        }

        Label { //Зададим текст для нашего заголовка
            x: 45
            anchors.verticalCenter: parent.verticalCenter
            opacity: 1
            color: "#ff0000"
            text: "Лабораторная 7. \n SSL сюдааа."
            font.family: "Times New Roman"
            font.pixelSize: Qt.application.font.pixelSize * 0.75
            padding: 10
        }

    }

    TextField{
        id: textforkey
        placeholderText: qsTr("Enter your AES key")
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: TextInput.AlignHCenter
        width: 320
        height: 50
        font.family: "Helvetica"
        font.pixelSize: 15
        anchors.bottomMargin: 20
        maximumLength: 32
    }

    ScrollView {
        id: viewlab6
        // Streamline the text
        clip: true
        // Turn on interactive showing of scroll bars.
        ScrollBar.horizontal.interactive: true
        ScrollBar.vertical.interactive: true
        width: 550
        height: 200
        anchors.topMargin: 60
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: textforkey.top
        TextArea{
            id: cryptoHolder
            // Just a placeholder
            placeholderText: qsTr("Your text decrypted there")
            readOnly: true
            placeholderTextColor: "darkgray"
            background: Rectangle {
                // Background of text area.
                border.color: cryptoHolder.enabled ? "black" : "transparent"
            }
        }
    }


    Button{
        id: chipheronlab6
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: viewlab6.bottom
        text: "Encrypt by Enigma"
        font.family: "Helvetica"
        font.pixelSize: 18
        anchors.topMargin: 15
        visible: if(fileDialoglab6.fileUrl === 0)
                     false
                 else
                     true
        onClicked: {
            cryptoController.encryptFile(textforkey.text, fileDialoglab6.fileUrls)
        }

        background: Rectangle {
                                    implicitWidth: 100
                                    implicitHeight: 40
                                    color: button.down ? "#d6d6d6" : "#f6f6f6"
                                    border.color: "#26282a"
                                    border.width: 1
                                    radius: 4
                                }
    }

    Button{
        id: chipherofflab6
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: chipheronlab6.bottom
        anchors.topMargin: 20
        text: "Decrypt by Cryptographic bomb"
        font.family: "Helvetica"
        font.pixelSize: 18
        visible: if(fileDialoglab6.fileUrl === 0)
                     false
                 else
                     true
        onClicked: {
            cryptoHolder.text = cryptoController.decryptFile(textforkey.text, fileDialoglab6.fileUrls)
        }

        background: Rectangle {
                                    implicitWidth: 100
                                    implicitHeight: 40
                                    color: button.down ? "#d6d6d6" : "#f6f6f6"
                                    border.color: "#26282a"
                                    border.width: 1
                                    radius: 4
                                }
    }

    Button {
        id: btnfordialoglab6
        font.pixelSize: 18
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: chipherofflab6.bottom
        anchors.topMargin: 20
        text: "Choose file"
        onClicked: fileDialoglab6.open()

        FileDialog {
            id: fileDialoglab6
            folder: "/Users/egorkuznetsov/Desktop"
        }

        background: Rectangle {
                                    implicitWidth: 100
                                    implicitHeight: 40
                                    color: button.down ? "#d6d6d6" : "#f6f6f6"
                                    border.color: "#26282a"
                                    border.width: 1
                                    radius: 4
                                }
    }
}
