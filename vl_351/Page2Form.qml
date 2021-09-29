import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0
import QtMultimedia 5.12

Page {
    background: Rectangle{
        color: "darkgrey"}
    id:page2
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
                text: qsTr("Лабораторная работа №2")
                color: "black"
                font.family: "Helvetica"; font.pointSize: 13; font.bold: true
                anchors.leftMargin: 3
                Layout.alignment: Qt.AlignLeft
            }
        }

    }
    ColumnLayout {
        anchors.fill:parent
        spacing: 8

        Row{ //расположение кнопок на одном ряду
            id:row2
            anchors.horizontalCenter: parent.horizontalCenter

            RadioButton {
                id: video
                text: qsTr("Видео")
                checked: true

                indicator: Rectangle {
                    implicitWidth: 25
                    implicitHeight: 25
                    x: video.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 13
                    border.color: video.down ? "#ff0000" : "black"

                    Rectangle {
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 7
                        color: video.down ? "#ff0000" : "black"
                        visible: video.checked
                    }
                }

                contentItem: Text {
                    text: video.text
                    font: video.font
                    opacity: enabled ? 1.0 : 0.3
                    color: video.down ? "#ff0000" : "black"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: video.indicator.width + video.spacing
                }
            }
            RadioButton {
                id: camera
                text: qsTr("Камера")
                checked: false

                indicator: Rectangle {
                    implicitWidth: 25
                    implicitHeight: 25
                    x: camera.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 13
                    border.color: camera.down ? "#ff0000" : "black"

                    Rectangle {
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 7
                        color: camera.down ? "#ff0000" : "black"
                        visible: camera.checked
                    }
                }

                contentItem: Text {
                    text: camera.text
                    font: camera.font
                    opacity: enabled ? 1.0 : 0.3
                    color: camera.down ? "#ff0000" : "black"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: camera.indicator.width + camera.spacing
                }
            }
        }
        RowLayout{
            Item{ // вкладка видео
                id: page_v
                width: parent.width
                height: parent.height
                ColumnLayout{
                    width: parent.width
                    height: parent.height

                    Row{

                        MediaPlayer{
                            id: val_video
                            source: "qrc:/../../Users/1/Новая папка/Загрузки/sample.mp4"
                            volume: slid_vol.value //громкость видео настраивается на slid_vol
                        }
                    }
                    RowLayout{
                        Layout.fillWidth: true
                        RoundButton{

                            Image {
                                id: stop
                                height: 40
                                width: 40
                                source: "qrc:/../../Users/1/Новая папка/Загрузки/stop-button.png"
                            }
                            ColorOverlay { //цвет для картинки
                                anchors.fill: stop
                                source: stop
                                color: "#ff0000"
                            }
                            flat: true
                            onClicked: val_video.stop() //остановка видео
                        }
                        RoundButton{

                            Image {
                                height: 40
                                width: 40
                                id: play_pause
                                source: {
                                    if (val_video.playbackState == MediaPlayer.PlayingState) //PlayingState - медиафайл в данный момент воспроизводится.
                                        return ":/../../Users/1/Новая папка/Загрузки/pause.png"
                                    else
                                        return ":/../../Users/1/Новая папка/Загрузки/play-button.png"
                                }

                            }
                            ColorOverlay { //цвет для картинки
                                anchors.fill: play_pause // на весь слайдер
                                source: play_pause//источник
                                color: "#ff0000"
                            }

                            flat: true //кнопка плоская

                            onClicked: {
                                if (val_video.playbackState == MediaPlayer.PlayingState)
                                    return val_video.pause();
                                else
                                    return val_video.play();
                            }
                        }


                            Slider {
                                id: slid_vol
                                from: 0
                                to: 1
                                value: 0.2

                                background: Rectangle {
                                    x: slid_vol.leftPadding
                                    y: slid_vol.topPadding + slid_vol.availableHeight / 2 - height / 2
                                    implicitWidth: 200
                                    implicitHeight: 4
                                    width: slid_vol.availableWidth
                                    height: implicitHeight
                                    radius: 2
                                    color: "black"

                                    Rectangle {
                                        width: slid_vol.visualPosition * parent.width
                                        height: parent.height
                                        color: "#ff0000"
                                        radius: 2
                                    }
                                }

                                handle: Rectangle {
                                    x: slid_vol.leftPadding + slid_vol.visualPosition * (slid_vol.availableWidth - width)
                                    y: slid_vol.topPadding + slid_vol.availableHeight / 2 - height / 2
                                    implicitWidth: 20
                                    implicitHeight: 20
                                    radius: 13
                                    color: slid_vol.pressed ? "pink" : "#ff0000"
                                    border.color: "black"
                                }

                            }
                        anchors.horizontalCenter: slid_time.horizontalCenter
                        anchors.top:slid_time.bottom

                    }

                    Slider {
                        id: slid_time
                        from: 0
                        to: val_video.duration
                        value: val_video.position
                        Material.accent: Material.Blue
                        anchors.horizontalCenter: outv.horizontalCenter
                        anchors.top:outv.bottom
                        Layout.fillWidth:  true
                        anchors.left: parent.left
                        anchors.right: parent.right
                        onPressedChanged: {
                            val_video.seek(slid_time.value) //при сдвиге позиция видео меняется
                        }

                        background: Rectangle {
                            x: slid_time.leftPadding
                            y: slid_time.topPadding + slid_time.availableHeight / 2 - height / 2
                            implicitWidth: 200
                            implicitHeight: 4
                            width: slid_time.availableWidth
                            height: implicitHeight
                            radius: 2
                            color: "#001624"

                            Rectangle {
                                width: slid_time.visualPosition * parent.width
                                height: parent.height
                                color: "#ff0000"
                                radius: 2
                            }
                        }

                        handle: Rectangle {
                            x: slid_time.leftPadding + slid_time.visualPosition * (slid_time.availableWidth - width)
                            y: slid_time.topPadding + slid_time.availableHeight / 2 - height / 2
                            implicitWidth: 20
                            implicitHeight: 20
                            radius: 13
                            color: slid_time.pressed ? "pink" : "#ff0000"
                            border.color: "black"
                        }
                    }



                    VideoOutput { //отображение видео
                        id: outv
                        source: val_video
                        autoOrientation: false
                        anchors.fill: parent
                        anchors.topMargin: 20
                        anchors.bottomMargin: 100
                        Layout.fillWidth: true
                    }


                    visible: {
                        if(video.checked == true){
                            return true
                        }
                        else
                            return false
                    }
                }
            }
            Item { // страница с камерой

                              id: page_c
                              anchors.left: parent.left
                              anchors.right: parent.right
                              anchors.top: camera1.bottom
                              anchors.bottom: parent.bottom
                              anchors.verticalCenter: parent.verticalCenter

                              Camera{
                                  id: camera1

                                  captureMode: stop()
                                  imageCapture{
                                      onImageCaptured: {
                                          photoPreview.source = preview
                                      }
                                  }
                              }


                              VideoOutput{ //отображение камеры
                                  id: videoCam
                                  source: camera1
                                  focus :  visible
                                  autoOrientation:true //автоориентация.Для телефона, чтобы камера отображалась корректно.
                                  anchors.left: parent.left
                                  anchors.right:parent.right
                                  anchors.top: camera1.bottom
                                  anchors.bottom: page_c.bottom
                                  anchors.leftMargin: 20
                                  anchors.rightMargin: 20
                                  anchors.bottomMargin: 45
                                  anchors.verticalCenter: parent.verticalCenter
                                  anchors.horizontalCenter: parent.horizontalCenter

                              }

                              Image { //превьюшка фоток
                                  Layout.column: 1
                                  Layout.row: 0
                                  id:  photoPreview

                                  anchors.horizontalCenter: parent.horizontalCenter
                                  height: 150
                                  width: 200
                              }
                              RowLayout{
                                  Layout.alignment: Qt.AlignCenter

                                  Layout.columnSpan: 3
                                  Layout.row: 2
                                  RoundButton{
                                      id: foto_button
                                      Layout.leftMargin: 8
                                      anchors.top:camera1.bottom
                                      anchors.topMargin: 10

                                      Image {
                                          id:cam_btn
                                          source: {
                                              if (camera1.videoRecorder.recorderState === CameraRecorder.StoppedState) //StoppedState-камера не записывает видео.
                                                  return ":/../../Users/1/Новая папка/Загрузки/cam.png"

                                              else if (camera1.videoRecorder.recorderStatus === CameraRecorder.PausedStatus) //PausedStatus-Запись приостановлена.
                                                  return ":/../../Users/1/Новая папка/Загрузки/new_play.png"
                                          }
                                      }
                                      ColorOverlay { //цвет для картинки
                                          anchors.fill: cam_btn // на весь слайдер
                                          source: cam_btn//источник
                                          color: "#ff0000"
                                      }

                                      flat: true
                                      onClicked: {
                                          if (camera1.videoRecorder.recorderState === CameraRecorder.StoppedState){ //StoppedState-камера не записывает видео.
                                              camera1.imageCapture.capture() // метод захвата неподвижного объекта (фото)
                                              camera1.imageCapture.captureToLocation("C:/vid/")
                                              }
                                          else if (camera1.videoRecorder.recorderStatus === CameraRecorder.RecordingStatus) //RecordingState-Камера записывает видео.
                                              camera1.videoRecorder.recorderStatus = CameraRecorder.PausedStatus //PausedStatus-Запись приостановлена.
                                          else if (camera1.videoRecorder.recorderStatus === CameraRecorder.PausedStatus) //PausedStatus-Запись приостановлена.
                                              camera1.videoRecorder.recorderStatus = CameraRecorder.RecordingStatus //RecordingState-Камера записывает видео.
                                      }
                                  }

                                  RoundButton { //кнопка - начать видео или остановить его
                                      id: video_button

                                      Image {
                                          id:cam_v_btn
                                          source: {
                                              if (camera1.videoRecorder.recorderStatus === CameraRecorder.RecordingStatus) //RecordingState-Камера записывает видео.
                                                  return ":/../../Users/1/Новая папка/Загрузки/new_stop.png"
                                              else
                                                  return ":/../../Users/1/Новая папка/Загрузки/v_cam.png"
                                          }
                                      }
                                      ColorOverlay { //цвет для картинки
                                          anchors.fill: cam_v_btn // на весь слайдер
                                          source: cam_v_btn//источник
                                          color: "#ff0000"
                                      }

                                      flat: true
                                      onClicked: {
                                          if(camera1.videoRecorder.recorderState === CameraRecorder.StoppedState){ //StoppedState-камера не записывает видео.
                                              camera1.videoRecorder.outputLocation = "C:/vid/";

                                              camera1.videoRecorder.record() // начать запись
                                          }
                                          else
                                              camera1.videoRecorder.stop() // остановить
                                      }
                                  }
                              }

                              visible: { //отображение страницы, когда кнопка видео не нажата
                                  if(video.checked == false){
                                      return true
                                  }
                                  else
                                      return false
                              }
                          }

                      }
                  }
   }
