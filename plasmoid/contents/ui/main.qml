import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.1 as PlasmaCore

Item {
    id: main

    // Declaramos 'units' para acceder fácilmente a 'PlasmaCore.Units'
    property var units: PlasmaCore.Units

    property string deviceName
    property string batteryPercent

    Plasmoid.fullRepresentation: ColumnLayout {
        anchors.centerIn: parent
        spacing: units.gridUnit
        Layout.minimumWidth: units.gridUnit * 20
        Layout.minimumHeight: units.gridUnit * 40

        // Encabezado principal
        PlasmaComponents3.Label {
            id: mainHeader
            text: i18n("Configuración del Headset")
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }

        // Información del dispositivo
        PlasmaComponents3.Label {
            id: deviceInfo
            text: i18n("Dispositivo: ") + deviceName
            Layout.fillWidth: true
        }

        PlasmaComponents3.Label {
            id: batteryInfo
            text: i18n("Nivel de batería: ") + batteryPercent
            Layout.fillWidth: true
        }

        // Sección para ajustar el Sidetone
        PlasmaComponents3.Label {
            text: i18n("Ajustar Sidetone")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents3.Slider {
            id: sidetoneSlider
            from: 0
            to: 128
            stepSize: 1
            value: 64
            Layout.fillWidth: true
            onValueChanged: {
                sidetoneValue.text = i18n("Valor: ") + value
                cmd.exec("headsetcontrol -s " + value)
            }
        }

        PlasmaComponents3.Label {
            id: sidetoneValue
            text: i18n("Valor: ") + sidetoneSlider.value
            Layout.fillWidth: true
        }

        // Sección para ajustar el Tiempo de Inactividad
        PlasmaComponents3.Label {
            text: i18n("Ajustar Tiempo de Inactividad (minutos)")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents3.Slider {
            id: inactiveTimeSlider
            from: 0
            to: 90
            stepSize: 1
            value: 0
            Layout.fillWidth: true
            onValueChanged: {
                inactiveTimeValue.text = i18n("Valor: ") + value
                cmd.exec("headsetcontrol -i " + value)
            }
        }

        PlasmaComponents3.Label {
            id: inactiveTimeValue
            text: i18n("Valor: ") + inactiveTimeSlider.value
            Layout.fillWidth: true
        }

        // Sección para ajustar el ChatMix
        PlasmaComponents3.Label {
            text: i18n("Ajustar ChatMix")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents3.Slider {
            id: chatMixSlider
            from: 0
            to: 128
            stepSize: 1
            value: 64
            Layout.fillWidth: true
            onValueChanged: {
                chatMixValue.text = i18n("Valor: ") + value
                cmd.exec("headsetcontrol -m " + value)
            }
        }

        PlasmaComponents3.Label {
            id: chatMixValue
            text: i18n("Valor: ") + chatMixSlider.value
            Layout.fillWidth: true
        }

        // Sección para el Limitador de Volumen
        PlasmaComponents3.Label {
            text: i18n("Limitador de Volumen")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents3.Switch {
            id: volumeLimiterSwitch
            checked: false
            text: checked ? i18n("Activado") : i18n("Desactivado")
            Layout.fillWidth: true
            onCheckedChanged: {
                cmd.exec("headsetcontrol --volume-limiter " + (checked ? "1" : "0"))
            }
        }

        // Sección para seleccionar el Preset del Ecualizador
        PlasmaComponents3.Label {
            text: i18n("Preset de Ecualizador")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents3.ComboBox {
            id: equalizerPresetCombo
            model: [i18n("Predeterminado"), i18n("Preset 1"), i18n("Preset 2"), i18n("Preset 3")]
            currentIndex: 0
            Layout.fillWidth: true
            onCurrentIndexChanged: {
                cmd.exec("headsetcontrol -p " + currentIndex)
            }
        }

        // Sección para ajustar el Volumen del Micrófono
        PlasmaComponents3.Label {
            text: i18n("Volumen del Micrófono")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents3.Slider {
            id: microphoneVolumeSlider
            from: 0
            to: 128
            stepSize: 1
            value: 64
            Layout.fillWidth: true
            onValueChanged: {
                microphoneVolumeValue.text = i18n("Valor: ") + value
                cmd.exec("headsetcontrol --microphone-volume " + value)
            }
        }

        PlasmaComponents3.Label {
            id: microphoneVolumeValue
            text: i18n("Valor: ") + microphoneVolumeSlider.value
            Layout.fillWidth: true
        }

        // Sección para ajustar el Brillo del LED de Mute del Micrófono
        PlasmaComponents3.Label {
            text: i18n("Brillo LED Mute Micrófono")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents3.Slider {
            id: micMuteLedSlider
            from: 0
            to: 3
            stepSize: 1
            value: 3
            Layout.fillWidth: true
            onValueChanged: {
                micMuteLedValue.text = i18n("Valor: ") + value
                cmd.exec("headsetcontrol --microphone-mute-led-brightness " + value)
            }
        }

        PlasmaComponents3.Label {
            id: micMuteLedValue
            text: i18n("Valor: ") + micMuteLedSlider.value
            Layout.fillWidth: true
        }

        // Sección para los ajustes de Bluetooth
        PlasmaComponents3.Label {
            text: i18n("Ajustes de Bluetooth")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents3.Switch {
            id: btPowerSwitch
            checked: true
            text: checked ? i18n("Bluetooth al encender: Activado") : i18n("Bluetooth al encender: Desactivado")
            Layout.fillWidth: true
            onCheckedChanged: {
                cmd.exec("headsetcontrol --bt-when-powered-on " + (checked ? "1" : "0"))
            }
        }

        PlasmaComponents3.ComboBox {
            id: btCallVolumeCombo
            model: [i18n("0"), i18n("1"), i18n("2")]
            currentIndex: 0
            Layout.fillWidth: true
            onCurrentIndexChanged: {
                cmd.exec("headsetcontrol --bt-call-volume " + currentIndex)
            }
        }
    }

    // DataSource para obtener información del dispositivo y batería en formato JSON
    PlasmaCore.DataSource {
        id: deviceDataSource
        engine: "executable"
        connectedSources: ["headsetcontrol -o json"]
        interval: 5000
        onNewData: {
            var output = data["stdout"];
            var jsonData = JSON.parse(output);
            if (jsonData.device_count > 0) {
                var device = jsonData.devices[0];
                main.deviceName = device.device;
                main.batteryPercent = device.battery.level + "%";
            }
        }
    }

    // DataSource para ejecutar comandos
    PlasmaCore.DataSource {
        id: cmd
        engine: "executable"
        connectedSources: []
        onNewData: {
            var exitCode = data["exit code"]
            var exitStatus = data["exit status"]
            var stdout = data["stdout"]
            var stderr = data["stderr"]
            exited(exitCode, exitStatus, stdout, stderr)
            disconnectSource(sourceName)
        }
        function exec(cmdstr) {
            connectSource(cmdstr)
        }
        signal exited(int exitCode, int exitStatus, string stdout, string stderr)
    }

    Plasmoid.toolTipSubText: i18n("Configuración del Headset")
}
