function gotoCivicQuestionPage() {
	Rho.System.openUrl("https://www.uscis.gov/sites/default/files/USCIS/Office%20of%20Citizenship/Citizenship%20Resource%20Center%20Site/Publications/100q.pdf");
}

function gotoCivicTestPage() {
	Rho.WebView.navigate("https://my.uscis.gov/en/prep/test/civics/new");
}

function refreshCurrentPage() {
	Rho.WebView.refresh();
}