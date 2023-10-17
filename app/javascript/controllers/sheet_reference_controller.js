// app/javascript/controllers/sheet_reference_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "form", "input" ]

  connect() {
    this.formTarget.addEventListener('submit', (event) => this.handleFormSubmit(event))
  }

  disconnect() {
    this.formTarget.removeEventListener('submit', (event) => this.handleFormSubmit(event))
  }

  handleFormSubmit(event) {
    event.preventDefault();

    const sheetId = this.inputTarget.value;
    const newActionUrl = "/sheets/" + sheetId;

    this.formTarget.action = newActionUrl;
    this.formTarget.submit();
  }
}
