// = require ./option_attached_inputs.component
// = require ./autosortable_checkboxes.component
// = require ./max_choices_alert.component
// = require ./display_conditions.component

((exports) => {
  const { createOptionAttachedInputs, createAutosortableCheckboxes, createDisplayConditions, createMaxChoicesAlertComponent } = exports.Decidim;

  $(".radio-button-collection, .check-box-collection").each((idx, el) => {
    createOptionAttachedInputs({
      wrapperField: $(el),
      controllerFieldSelector: "input[type=radio], input[type=checkbox]",
      dependentInputSelector: "input[type=text], input[type=hidden]"
    });
  });

  $.unique($(".check-box-collection").parents(".answer")).each((idx, el) => {
    createMaxChoicesAlertComponent({
      wrapperField: $(el),
      controllerFieldSelector: "input[type=checkbox]",
      controllerCollectionSelector: ".check-box-collection",
      alertElement: $(el).find(".max-choices-alert"),
      maxChoices: $(el).data("max-choices")
    })
  });

  $(".sortable-check-box-collection").each((idx, el) => {
    createAutosortableCheckboxes({
      wrapperField: $(el)
    })
  });

  $(".answer-questionnaire .question[data-conditioned='true']").each((idx, el) => {
    createDisplayConditions({
      wrapperField: $(el)
    });
  });

})(window);
