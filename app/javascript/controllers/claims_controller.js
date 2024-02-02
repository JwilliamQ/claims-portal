import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["tab", "claims"];

  connect() {
    this.switchTab("pending");
  }

  switchTab(event) {
    const status = event.target.dataset.status;

    this.tabTargets.forEach((tab) => {
      tab.classList.remove("active");
    });
    event.target.classList.add("active");

    fetch(`/claims?status=${status}`)
      .then((response) => response.text())
      .then((data) => {
        this.claimsTarget.innerHTML = data;
      });
  }
}