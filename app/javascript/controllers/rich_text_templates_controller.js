import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "modal", "input"]

  connect() {
    this.templateTargets.forEach(element => {
      this.modalTarget.innerHTML += `
      <p class="text-small mb-3">
        <b>
          ${element.dataset.templateName}
        </b>
        <br />
        ${element.dataset.templateDescription}
        <br />
        <button type="button" data-action="click->rich-text-templates#useTemplate click->modal#close" data-rich-text-templates-template-name-param="${element.dataset.templateName}" class="text-indigo-400">
          Select
        </button>
      </p>
      `
    });
  }

  useTemplate(event) {
    let selectedTemplate = this.templateTargets.find(element => element.dataset.templateName === event.params.templateName)
    this.inputTarget.value = selectedTemplate.innerHTML 
  }
}
