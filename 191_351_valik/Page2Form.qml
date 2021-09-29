import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtMultimedia 5.4
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.12
//import QtWebView 1.1
import QtQml 2.12
import QtWebSockets 1.1

Page {
      id:page4GUI
      header : ToolBar{ //создание панели
          background: Rectangle { //создание фона
              id:rec1
              color: "#001624"}
                              GridLayout{
                              id:layout1
                              anchors.fill:parent //по ширине родителя
                              columns:2
                              rows: 1
                                        Label {
                                               Layout.row:0
                                               Layout.column:1
                                               id: lab1
                                               text: "Лабораторная работа №4"
                                               color: "#83bbde"
                                               //Layout.alignment: Qt.AlignCenter
                                               font.weight: Font.Medium
                                               font.pointSize: 15
                                               font.family: "Arial"
                                        }
                                               Image {
                                               id: imag
                                               Layout.row:0
                                               Layout.column:0
                                               source: "qrc:/image/imgonline-com-ua-Resize-xQETFjaEy3.png"
                                               //anchors.left:parent.left //привязка справа от родителя
                                               //anchors.leftMargin: 5
                                               }

                                        }

                            }
    GridLayout{
          anchors.fill:parent
          anchors.bottomMargin: 40
          Item {
              Layout.row: 0
              Layout.column: 0
 Layout.alignment: Qt.AlignCenter
 /***
              WebView{
                  id: webView
                  url: "https://oauth.vk.com/authorize?client_id=7900945&redirect_uri=&response_type=token&v=5.131"
                  //url:"https://oauth.vk.com/authorize?client_id=7834404&redirect_uri=&response_type=token&v=5.92"
                  Layout.fillWidth: true
                  Layout.fillHeight: true
                  onLoadingChanged: {
                      console.info("*** "+ webView.url)

                      success(webView.url)


                      var token = webappcontroller.success(webView.url)

                      if(token !== " "){
                          tokens.text = token
                          tokens.visible = token === " " ? false : true;
                          mailButton.visible = token === " " ? false : true;
                          webView.visible = token === " " ? true : false;
                      }
                  }
              }
              ***/

              Label{
                  id:tokens
                  visible: false
                  font.pixelSize: 12
                  Layout.alignment: Qt.AlignCenter
                  objectName: "TokenPokesh"
              }

              Label{
                  visible: false
                  Layout.row: 4
                  Layout.alignment: Qt.AlignCenter
                  id:labelreturn
                   font.pixelSize: 30
                  text: "Закрытие соединения!"
              }
  }
      Button {
          Layout.row: 1
          Layout.column: 0
Layout.alignment: Qt.AlignCenter
          id: mailButton
          text: qsTr("Показать список друзей")
          visible: false
          onClicked: {
              restRequest();
          }

          contentItem: Text {
              text: mailButton.text
              font: mailButton.font
              opacity: enabled ? 1.0 : 0.3
              color: mailButton.down ? "#001624" : "#83bbde"
              horizontalAlignment: Text.AlignHCenter
              verticalAlignment: Text.AlignVCenter
              elide: Text.ElideRight
          }

          background: Rectangle {
              implicitWidth: 100
              implicitHeight: 40
              opacity: enabled ? 1 : 0.3
              border.color: mailButton.down ? "#83bbde" : "#001624"
              border.width: 1
              radius: 2
          }
      }
}

      }
