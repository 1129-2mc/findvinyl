import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.initializeSelect2();
  }

  disconnect() {
    this.destroySelect2();
  }

  initializeSelect2() {
    $(this.element).find('.select2').each(function() {
      // select2が未初期化の場合のみ初期化
      if (!$(this).data('select2')) {
        $(this).select2();
      }
    });
  }

  destroySelect2() {
    $(this.element).find('.select2').each(function() {
      try {
        // select2が初期化されている場合のみ破棄処理を行う
        if ($(this).data('select2')) {
          $(this).select2('destroy');
        }
      } catch (e) {
        console.warn('Failed to destroy Select2:', e);
      }
    });
  }
}
