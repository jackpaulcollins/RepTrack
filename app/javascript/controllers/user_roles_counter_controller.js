import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["element", "output", "warningWrapper"]

  connect() {
    this.updateCount()
  }
  
  elementTargetConnected(){
    this.updateCount()
  }

  elementTargetDisconnected(){
    this.updateCount()
  }

  updateCount() {
    let count = this.elementTargets.filter((el) => el.offsetParent != null).length
    this.outputTarget.innerHTML = count
    if(count > 4) {
      this.warningWrapperTarget.style.display = "block";
    } else {
      this.warningWrapperTarget.style.display = "none";
    }
  }
}
