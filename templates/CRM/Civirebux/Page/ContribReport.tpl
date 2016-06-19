<p>Hi {loggedin_user}!!</p>

{* Example: Display a translated string -- which happens to include a variable *}
<p>{ts 1=$currentTime}(In your native language) The current time is %1.{/ts}</p>

<h3>Pivot Table</h3>
<div id="reportPivotTable"></div>
{literal}
<script type="text/javascript">
    CRM.$(function () {
        var data = {/literal}{$contribData}{literal};
        /*** PivotTable library initialization: ***/
        jQuery("#reportPivotTable").pivotUI(data, {
            rendererName: "Table",
            renderers: CRM.$.extend(
                jQuery.pivotUtilities.renderers,
                jQuery.pivotUtilities.c3_renderers,
                jQuery.pivotUtilities.export_renderers
            ),
            vals: ["Total"],
            rows: [],
            cols: [],
            aggregatorName: "Count",
            unusedAttrsVertical: false,
            derivedAttributes: {
                "Activity Start Date Months": jQuery.pivotUtilities.derivers.dateFormat("Activity Date", "%y-%m"),
                "Activity is a test": function(row) {
                    if (parseInt(row["Activity is a test"], 10) === 0) {
                        return "No";
                    }
                    return "Yes";
                },
                "Activity Expire Date": function(row) {
                  if (!row["Expire Date"]) {
                    return "";
                  }
                  var expireDateParts = row["Expire Date"].split(/(\d{1,2})\/(\d{1,2})\/(\d{4})/);
                  return expireDateParts[3] + "-" + expireDateParts[1] + "-" + expireDateParts[2];
                }
            },
            hiddenAttributes: ["Test", "Expire Date"]
        }, false);
    });
</script>
{/literal}
