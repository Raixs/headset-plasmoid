import QtQuick 2.4
import QtQuick.Layouts 1.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: main

    property string deviceName
    property string batteryPercent

    Plasmoid.fullRepresentation: ColumnLayout {
        anchors.centerIn: parent
        anchors.fill: parent
        spacing: units.gridUnit
        Layout.minimumWidth: units.gridUnit * 20
        Layout.minimumHeight: units.gridUnit * 40

        // Encabezado principal
        PlasmaComponents.Label {
            id: mainHeader
            text: i18n("Configuración del Headset")
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }

        // Información del dispositivo
        PlasmaComponents.Label {
            id: deviceInfo
            text: i18n("Dispositivo: ") + deviceName
            Layout.fillWidth: true
        }

        PlasmaComponents.Label {
            id: batteryInfo
            text: i18n("Nivel de batería: ") + batteryPercent
            Layout.fillWidth: true
        }

        // Sección para ajustar el Sidetone
        PlasmaComponents.Label {
            text: i18n("Ajustar Sidetone")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents.Slider {
            id: sidetoneSlider
            minimumValue: 0
            maximumValue: 128
            stepSize: 1
            value: 64
            Layout.fillWidth: true
            onValueChanged: {
                sidetoneValue.text = i18n("Valor: ") + value
                cmd.exec("headsetcontrol -s " + value)
            }
        }

        PlasmaComponents.Label {
            id: sidetoneValue
            text: i18n("Valor: ") + sidetoneSlider.value
            Layout.fillWidth: true
        }

        // Sección para ajustar el Tiempo de Inactividad
        PlasmaComponents.Label {
            text: i18n("Ajustar Tiempo de Inactividad (minutos)")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents.Slider {
            id: inactiveTimeSlider
            minimumValue: 0
            maximumValue: 90
            stepSize: 1
            value: 0
            Layout.fillWidth: true
            onValueChanged: {
                inactiveTimeValue.text = i18n("Valor: ") + value
                cmd.exec("headsetcontrol -i " + value)
            }
        }

        PlasmaComponents.Label {
            id: inactiveTimeValue
            text: i18n("Valor: ") + inactiveTimeSlider.value
            Layout.fillWidth: true
        }

        // Sección para ajustar el ChatMix
        PlasmaComponents.Label {
            text: i18n("Ajustar ChatMix")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents.Slider {
            id: chatMixSlider
            minimumValue: 0
            maximumValue: 128
            stepSize: 1
            value: 64
            Layout.fillWidth: true
            onValueChanged: {
                chatMixValue.text = i18n("Valor: ") + value
                cmd.exec("headsetcontrol -m " + value)
            }
        }

        PlasmaComponents.Label {
            id: chatMixValue
            text: i18n("Valor: ") + chatMixSlider.value
            Layout.fillWidth: true
        }

        // Sección para el Limitador de Volumen
        PlasmaComponents.Label {
            text: i18n("Limitador de Volumen")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents.Switch {
            id: volumeLimiterSwitch
            checked: false
            text: checked ? i18n("Activado") : i18n("Desactivado")
            Layout.fillWidth: true
            onCheckedChanged: {
                cmd.exec("headsetcontrol --volume-limiter " + (checked ? "1" : "0"))
            }
        }

        // Sección para seleccionar el Preset del Ecualizador
        PlasmaComponents.Label {
            text: i18n("Preset de Ecualizador")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents.ComboBox {
            id: equalizerPresetCombo
            model: [i18n("Predeterminado"), i18n("Preset 1"), i18n("Preset 2"), i18n("Preset 3")]
            currentIndex: 0
            Layout.fillWidth: true
            onCurrentIndexChanged: {
                cmd.exec("headsetcontrol -p " + currentIndex)
            }
        }

        // Sección para ajustar el Volumen del Micrófono
        PlasmaComponents.Label {
            text: i18n("Volumen del Micrófono")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents.Slider {
            id: microphoneVolumeSlider
            minimumValue: 0
            maximumValue: 128
            stepSize: 1
            value: 64
            Layout.fillWidth: true
            onValueChanged: {
                microphoneVolumeValue.text = i18n("Valor: ") + value
                cmd.exec("headsetcontrol --microphone-volume " + value)
            }
        }

        PlasmaComponents.Label {
            id: microphoneVolumeValue
            text: i18n("Valor: ") + microphoneVolumeSlider.value
            Layout.fillWidth: true
        }

        // Sección para ajustar el Brillo del LED de Mute del Micrófono
        PlasmaComponents.Label {
            text: i18n("Brillo LED Mute Micrófono")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents.Slider {
            id: micMuteLedSlider
            minimumValue: 0
            maximumValue: 3
            stepSize: 1
            value: 3
            Layout.fillWidth: true
            onValueChanged: {
                micMuteLedValue.text = i18n("Valor: ") + value
                cmd.exec("headsetcontrol --microphone-mute-led-brightness " + value)
            }
        }

        PlasmaComponents.Label {
            id: micMuteLedValue
            text: i18n("Valor: ") + micMuteLedSlider.value
            Layout.fillWidth: true
        }

        // Sección para los ajustes de Bluetooth
        PlasmaComponents.Label {
            text: i18n("Ajustes de Bluetooth")
            font.bold: true
            Layout.topMargin: units.gridUnit * 2
            Layout.fillWidth: true
        }

        PlasmaComponents.Switch {
            id: btPowerSwitch
            checked: true
            text: checked ? i18n("Bluetooth al encender: Activado") : i18n("Bluetooth al encender: Desactivado")
            Layout.fillWidth: true
            onCheckedChanged: {
                cmd.exec("headsetcontrol --bt-when-powered-on " + (checked ? "1" : "0"))
            }
        }

        PlasmaComponents.ComboBox {
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
