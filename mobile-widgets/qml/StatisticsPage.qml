// SPDX-License-Identifier: GPL-2.0
import QtQuick 2.6
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.2
import org.subsurfacedivelog.mobile 1.0
import org.kde.kirigami 2.4 as Kirigami

Kirigami.Page {
	id: statisticsPage
	objectName: "StatisticsPage"
	title: qsTr("Statistics")
	leftPadding: 0
	topPadding: 0
	rightPadding: 0
	bottomPadding: 0
	width: rootItem.width
	implicitWidth: rootItem.width
	property bool wide: width > rootItem.height
	StatsManager {
		id: statsManager
	}
	onVisibleChanged: {
		if (visible)
			statsManager.doit()
	}
	onWidthChanged: {
		if (visible) {
			statsManager.doit()
		}
	}

	GridLayout {
		anchors.fill: parent
		ColumnLayout {
			id: i1
			Layout.column: 0
			Layout.row: 0
			Layout.leftMargin: Kirigami.Units.smallSpacing
			Layout.topMargin: Kirigami.Units.smallSpacing
			TemplateLabelSmall {
				text: qsTr("Base variable")
			}
			TemplateSlimComboBox  {
				id: var1
				model: statsManager.var1List
				currentIndex: statsManager.var1Index;
				onCurrentIndexChanged: {
					statsManager.var1Changed(currentIndex)
				}
			}
		}
		ColumnLayout {
			id: i2
			Layout.column: wide ? 0 : 1
			Layout.row: wide ? 1 : 0
			Layout.leftMargin: Kirigami.Units.smallSpacing
			TemplateLabelSmall {
				text: qsTr("Binning")
			}
			TemplateSlimComboBox {
				id: var1Binner
				model: statsManager.binner1List
				currentIndex: statsManager.binner1Index;
				onCurrentIndexChanged: {
					statsManager.var1BinnerChanged(currentIndex)
				}
			}
		}
		ColumnLayout {
			id: i3
			Layout.column: wide ? 0 : 0
			Layout.row: wide ? 2 : 1
			Layout.leftMargin: Kirigami.Units.smallSpacing
			TemplateLabelSmall {
				text: qsTr("Data")
			}
			TemplateSlimComboBox {
				id: var2
				model: statsManager.var2List
				currentIndex: statsManager.var2Index;
				Layout.fillWidth: false
				onCurrentIndexChanged: {
					statsManager.var2Changed(currentIndex)
				}
			}
		}
		ColumnLayout {
			id: i4
			Layout.column: wide ? 0 : 1
			Layout.row: wide ? 3 : 1
			Layout.leftMargin: Kirigami.Units.smallSpacing
			TemplateLabelSmall {
				text: qsTr("Binning")
			}
			TemplateSlimComboBox {
				id: var2Binner
				model: statsManager.binner2List
				currentIndex: statsManager.binner2Index;
				Layout.fillWidth: false
				onCurrentIndexChanged: {
					statsManager.var2BinnerChanged(currentIndex)
				}
			}
		}
		ColumnLayout {
			id: i5
			Layout.column: wide ? 0 : 0
			Layout.row: wide ? 4 : 2
			Layout.leftMargin: Kirigami.Units.smallSpacing
			TemplateLabelSmall {
				text: qsTr("Operation")
			}
			TemplateSlimComboBox {
				id: var2Operation
				model: statsManager.operation2List
				currentIndex: statsManager.operation2Index;
				Layout.fillWidth: false
				onCurrentIndexChanged: {
					statsManager.var2OperationChanged(currentIndex)
				}
			}
		}
		Item {
			Layout.column: wide ? 0 : 1
			Layout.row: wide ? 5 : 2
			Layout.preferredHeight: wide ? parent.height - Kirigami.Units.gridUnit * 16 : Kirigami.Units.gridUnit
			Layout.preferredWidth: wide ? parent.width - i1.implicitWidt - i2.implicitWidt - i3.implicitWidt - i4.implicitWidth : Kirigami.Units.gridUnit
			// just used for spacing
		}

		StatsView {
			Layout.column: wide ? 1 : 0
			Layout.row: wide ? 0 : 3
			Layout.columnSpan: wide ? 1 : 3
			Layout.rowSpan: wide ? 6 : 1
			id: statsView
			Layout.margins: Kirigami.Units.smallSpacing
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.maximumHeight: wide ? statisticsPage.height - 2 * Kirigami.Units.gridUnit :
						     statisticsPage.height - 2 * Kirigami.Units.gridUnit - i4.height
			Layout.maximumWidth: wide ? statisticsPage.width - 2 * Kirigami.Units.gridUnit - i4.width :
						     statisticsPage.width - 2 * Kirigami.Units.smallSpacing

			onWidthChanged: {
				console.log("StatsView widget width is " + width + " on page with width " + statisticsPage.width)
			}
		}
	}
	Component.onCompleted: {
		statsManager.init(statsView, var1)
		console.log("Statistics widget loaded")
	}
}