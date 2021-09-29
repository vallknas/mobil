import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2 // подсказка конт пробел
import QtMultimedia 5.4
import QtWinExtras 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Universal 2.12
import Qt.labs.settings 1.0
import QtGraphicalEffects 1.12
import QtWebView 1.15

ApplicationWindow {
    signal success (string add);
    signal fail(string pop);
    signal restRequest();
    width: 640
    height: 480
    visible: true
    title: qsTr("Tabs")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1GUI {
        }

        Page2GUI {
        }
        Page3GUI{
        }
        Page4GUI{
        }
        Page5GUI{
        }
        Page6GUI{
        }
    }

    Drawer{
        id:drawer

        width: 0.66 * parent.width
        height: parent.height
        GridLayout{

            rows:15

            Button{
                Layout.row: 1
                text: qsTr("ЛР 3")
               onClicked: {

                   swipeView.currentIndex =0
                   drawer.close()
               }


            }
            Button {
                Layout.row: 2
                text: qsTr("ЛР 4")
                onClicked: {

                    swipeView.currentIndex =1
                    drawer.close()
                }
            }
            Button {
                Layout.row: 3
                text: qsTr("ЛР 5")
                onClicked: {

                    swipeView.currentIndex =2
                    drawer.close()
                }
            }
            Button {
                Layout.row: 4
                text: qsTr("ЛР 6")
                onClicked: {
                    swipeView.currentIndex =3
                    drawer.close()
                }
            }
            Button {
                Layout.row: 4
                text: qsTr("ЛР 7")
                onClicked: {

                    swipeView.currentIndex =4
                    drawer.close()
                }
            }

            Button {
                Layout.row: 4
                text: qsTr("ЛР 8")
                onClicked: {

                    swipeView.currentIndex =5
                    drawer.close()
                }
            }

        }

    }
}
