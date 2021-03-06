function replacePage(pageUrl) {
	location.replace(pageUrl);
}

function backgroundPage(pageUrl) {
	$.post(pageUrl);
}

function applyPanelId() {
	var panelId = $("#panelId-input-box").val();
	$.post("/app/Settings/storePanelId", {panelId: panelId}, postApplyPanelId);
}

function postApplyPanelId(data) {
	replacePage("/app/Settings/wait?mode=setup");
}

function showInfoPopup() {
	var popup = $("#info-popup");
	var popupBG = $("#info-popup-background");
	popup.fadeIn(400);
	popupBG.fadeIn(400);
}

function hideInfoPopup() {
	var popup = $("#info-popup");
	var popupBG = $("#info-popup-background");
	popup.fadeOut(400);
	popupBG.fadeOut(400);
}

function showWorkerPopup(workerId) {
	$.post("/app/Miner/index", {workerId: workerId}, postGrabWorkerData);
}

function postGrabWorkerData(data) {
	var popup = $("#worker-popup");
	var popupBG = $("#worker-popup-background");
	popup.html(data);
	popup.fadeIn(400);
	popupBG.fadeIn(400);
}

function hideWorkerPopup() {
	var popup = $("#worker-popup");
	var popupBG = $("#worker-popup-background");
	popup.fadeOut(400);
	popupBG.fadeOut(400);
}

function toggleCriticalSection() {
	var tapButton = $("#set-criti-toggler");
	var critiSection = $("#critical-values");
	if (critiSection.is(":visible")) {
		critiSection.slideUp(300);
		tapButton.val($("<div>").html("&rarr; Open Critical Settings &larr;").text());
	} else {
		critiSection.slideDown(300);
		tapButton.val($("<div>").html("&larr; Close Critical Settings &rarr;").text());
	}
}

function storeCriticalValues(value, type) {
	if (isNaN(value)) {
		$("#" + type + "-input").val("");
	} else {
		$.post("/app/Settings/updateCriticalVal", {criticalVal: value, criticalType: type});
	}
}