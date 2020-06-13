function toggle_home_address_fields() {
  const checked = $("input#form_inputs_home_address").prop("checked");
  change_visible("fieldset#home-address-fields", checked);
}

function toggle_work_address_fields() {
  const checked = $("input#form_inputs_work_address").prop("checked");
  change_visible("fieldset#work-address-fields", checked);
}

function change_visible(query, visible) {
  if (visible) {
    $(query).show();
  } else {
    $(query).hide();
  }
}

$(document).on("ready turbolinks:load", () => {
  toggle_home_address_fields();
  toggle_work_address_fields();
  $("input#form_inputs_home_address").on("click", () => {
    toggle_home_address_fields();
  });
  $("input#form_inputs_work_address").on("click", () => {
    toggle_work_address_fields();
  });
});
