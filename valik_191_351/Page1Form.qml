import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick 2.12
import QtQuick.Controls.Styles 1.4

Page {
    background: Rectangle{
        color: "darkgrey"}
    id:page
    header: ToolBar {
        anchors.fill: parent.width
        Label {
            id: lab1
            text: qsTr("YouTube")
            color: "black"
            font.family: "Helvetica"; font.pointSize: 13; font.bold: true
            anchors.leftMargin: 3
            Layout.alignment: Qt.AlignLeft
        }
        font.pixelSize: Qt.application.font.pixelSize * 2
        background: Rectangle {
            color: "#ff0000"
            id: images
            Layout.alignment: Qt.AlignRight
            Image {
                id: image1
                //implicitWidth: 18
                //implicitHeight:18
                width: 18
                height: 18
                source: "qrc:/../../Users/1/Новая папка/Загрузки/youtube (1).png"
                fillMode: Image.PreserveAspectFit
                anchors.right: parent.right
                anchors.rightMargin: 70;
                anchors.topMargin: 3
            }
            Image {
                id: image3
                //implicitHeight: 15
                //implicitWidth: 15
                width: 15
                height: 15
                source: "qrc:/../../Users/1/Новая папка/Загрузки/loupe.png"
                fillMode: Image.PreserveAspectFit
                anchors.right: parent.right
                anchors.rightMargin: 40;
                anchors.topMargin: 5
            }
            Image {
                id: image2
                width: 20
                height: 20
                source: "qrc:/../../Users/1/Новая папка/Загрузки/menu.png"
                fillMode: Image.PreserveAspectFit
                anchors.right: parent.right
                anchors.rightMargin: 5;
                anchors.topMargin: 3
            }
        }
    }


    GridLayout{
        anchors.fill:parent
        anchors.margins: 10

        TextField{
            id:texifield
            font.family: "Helvetica"; font.pointSize: 12;
            Layout.row: 0
            Layout.column: 0
            Layout.fillWidth: true
            Layout.fillHeight: true
            placeholderText: qsTr("Enter name")
            placeholderTextColor: "#ff0000"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignHCenter
            background:Rectangle{
                implicitWidth: 70
                implicitHeight: 20
                color: "black"

            }

        }

        TextArea {
            id: textarea
            font.family: "Helvetica"; font.pointSize: 12;
            placeholderText: qsTr("Enter description")
            Layout.row: 0
            Layout.column: 1
            Layout.fillWidth: true
            Layout.fillHeight: true
            placeholderTextColor: "#ff0000"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignHCenter
            background:Rectangle{
                implicitWidth: 70
                implicitHeight: 20
                color: "black"

            }
        }
        ProgressBar {
            id: cont
            value: 0.5
            padding: 2
            Layout.row: 1
            Layout.column: 0
            Layout.rowSpan: 1

            Layout.fillWidth: true
            indeterminate: true

            background: Rectangle {
                implicitWidth: 70
                implicitHeight: 6
                color: "black"
                radius: 3
            }

            contentItem: Item {
                implicitWidth: 70
                implicitHeight: 5

                Rectangle {
                    width: cont.visualPosition * parent.width
                    height: parent.height
                    radius: 2
                    color: "#ff0000"
                }
            }
        }



        BusyIndicator {
            id: indic
            Layout.row: 1
            Layout.column: 1
            Layout.alignment: Qt.AlignCenter

            contentItem: Item {
                implicitWidth: 64
                implicitHeight: 64

                Item {
                    id: item
                    x: parent.width / 2 - 32
                    y: parent.height / 2 - 32
                    width: 64
                    height: 64
                    opacity: indic.running ? 1 : 0

                    Behavior on opacity {
                        OpacityAnimator {
                            duration: 250
                        }
                    }

                    RotationAnimator {
                        target: item
                        running: indic.visible && indic.running
                        from: 0
                        to: 360
                        loops: Animation.Infinite
                        duration: 1250
                    }

                    Repeater {
                        id: repeater
                        model: 6

                        Rectangle {
                            x: item.width / 2 - width / 2
                            y: item.height / 2 - height / 2
                            implicitWidth: 10
                            implicitHeight: 10
                            radius: 5
                            color: "#ff0000"
                            transform: [
                                Translate {
                                    y: -Math.min(item.width, item.height) * 0.5 + 5
                                },
                                Rotation {
                                    angle: index / repeater.count * 360
                                    origin.x: 5
                                    origin.y: 5
                                }
                            ]
                        }
                    }
                }
            }
        }


            Dial {
                Layout.row: 2
                Layout.column: 0
                Layout.rowSpan: 1
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignCenter
                implicitHeight: 20
                implicitWidth: 70
                id: control
                background: Rectangle {
                    x: control.width / 2 - width / 2
                    y: control.height / 2 - height / 2
                    width: Math.max(64, Math.min(control.width, control.height))
                    height: width
                    color: "transparent"
                    radius: width / 2
                    border.color: control.pressed ? "#ff0000" : "#ff0023"
                    opacity: control.enabled ? 1 : 0.3
                }

                handle: Rectangle {
                    id: handleItem
                    x: control.background.x + control.background.width / 2 - width / 2
                    y: control.background.y + control.background.height / 2 - height / 2
                    width: 16
                    height: 16
                    color: control.pressed ? "#ff0000" : "#ff0023"
                    radius: 8
                    antialiasing: true
                    opacity: control.enabled ? 1 : 0.3
                    transform: [
                        Translate {
                            y: -Math.min(control.background.width, control.background.height) * 0.4 + handleItem.height / 2
                        },
                        Rotation {
                            angle: control.angle
                            origin.x: handleItem.width / 2
                            origin.y: handleItem.height / 2
                        }
                    ]
                }
        }
        Tumbler {
            id: tumblr
            Layout.row: 2
            Layout.column: 1
            Layout.rowSpan: 1
            Layout.alignment: Qt.AlignCenter
            model: 31 // количество записей
            implicitHeight: 40
            implicitWidth: 70
            Layout.fillHeight: true
            background: Item {
                Rectangle {
                    opacity: tumblr.enabled ? 0.2 : 0.1
                    border.color: "#ff0000"
                    width: parent.width
                    height: 1
                    anchors.top: parent.top
                }

                Rectangle {
                    opacity: tumblr.enabled ? 0.2 : 0.1
                    border.color: "#ff0000"
                    width: parent.width
                    height: 1
                    anchors.bottom: parent.bottom
                }
            }

            delegate: Text {
                text: qsTr("Item %1").arg(modelData + 1)
                font: tumblr.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                opacity: 1.0 - Math.abs(Tumbler.displacement) / (tumblr.visibleItemCount / 2)
            }

            Rectangle {
                anchors.horizontalCenter: tumblr.horizontalCenter
                y: tumblr.height * 0.4
                width: 40
                height: 1
                color: "#ff0000"
            }

            Rectangle {
                anchors.horizontalCenter: tumblr.horizontalCenter
                y: tumblr.height * 0.6
                width: 40
                height: 1
                color: "#ff0000"
            }

        }
    }

}
