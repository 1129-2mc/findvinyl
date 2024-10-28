import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    $(this.element).find('.select2').select2();
  }

  disconnect() {
    $(this.element).find('.select2').each(function() {
      try {
        // Select2が初期化されているか確認
        if ($(this).data('select2')) {
          // Select2インスタンスを破棄する
          $(this).select2('destroy');
        }
      } catch (e) {
        console.warn('Failed to destroy Select2:', e);
      }
    });
  }
}
