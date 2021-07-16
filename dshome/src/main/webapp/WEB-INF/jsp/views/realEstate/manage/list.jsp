<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
	#sidoList, #gugunList, #dongList {
		width: 32%;
		border: 1px solid #d1d3e2;
	}
	
	.custom-combobox {
    position: relative;
    display: inline-block;
  }
  .custom-combobox-toggle {
    position: absolute;
    top: 0;
    bottom: 0;
    margin-left: -1px;
    padding: 0;
  }
  .custom-combobox-input {
    margin: 0;
    padding: 5px 10px;
  }
</style>

<script>

$(function(){

	fn_cityList(null, 0);
	
	$("#sidoList").change(function(){
		
		$("#gugunList").empty().append(fn_option('', "-선택-", 1));
		$("#dongList").empty().append(fn_option('', "-선택-", 2));
		
		fn_cityList($(this).find(":selected").val(), "1");
		
	});
	
	$("#gugunList").change(function(){
		
		$("#dongList").empty().append(fn_option('', "-선택-", 2));
		
		fn_cityList($(this).find(":selected").val(), "2");
		
	});
	
	$("#dongList").change(function(){
		
		//$("#aptList").empty().append(fn_option('', "-선택-", ''));
		fn_aptList($(this).find(":selected").val());
	});
	
/* 	$.widget( "custom.combobox", {_create: function() {
		this.wrapper = $("<span>").addClass("custom-combobox").insertAfter( this.element );

		this.element.hide();
		this._createAutocomplete();
		this._createShowAllButton();
	},

	_createAutocomplete: function() {
		var selected = this.element.children(":selected"),value = selected.val() ? selected.text() : "";

		this.input = $( "<input>" )
            .appendTo( this.wrapper )
            .val( value )
            .attr( "title", "" )
            .addClass( "custom-combobox-input ui-widget ui-widget-content ui-state-default ui-corner-left" )
            .autocomplete({
              delay: 0,
              minLength: 0,
              source: $.proxy( this, "_source" )
            })
            .tooltip({
              classes: {
                "ui-tooltip": "ui-state-highlight"
              }
            });
   
          this._on( this.input, {
            autocompleteselect: function( event, ui ) {
              ui.item.option.selected = true;
              this._trigger( "select", event, {
                item: ui.item.option
              });
            },
   
            autocompletechange: "_removeIfInvalid"
          });
        },
   
        _createShowAllButton: function() {
          var input = this.input,
            wasOpen = false;
   
          $( "<a>" )
            .attr( "tabIndex", -1 )
            .attr( "title", "Show All Items" )
            .tooltip()
            .appendTo( this.wrapper )
            .button({
              icons: {
                primary: "ui-icon-triangle-1-s"
              },
              text: false
            })
            .removeClass( "ui-corner-all" )
            .addClass( "custom-combobox-toggle ui-corner-right" )
            .on( "mousedown", function() {
              wasOpen = input.autocomplete( "widget" ).is( ":visible" );
            })
            .on( "click", function() {
              input.trigger( "focus" );
   
              // Close if already visible
              if ( wasOpen ) {
                return;
              }
   
              // Pass empty string as value to search for, displaying all results
              input.autocomplete( "search", "" );
            });
        },
   
        _source: function( request, response ) {
          var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
          response( this.element.children( "option" ).map(function() {
            var text = $( this ).text();
            if ( this.value && ( !request.term || matcher.test(text) ) )
              return {
                label: text,
                value: text,
                option: this
              };
          }) );
        },
   
        _removeIfInvalid: function( event, ui ) {
   
          // Selected an item, nothing to do
          if ( ui.item ) {
            return;
          }
   
          // Search for a match (case-insensitive)
          var value = this.input.val(),
            valueLowerCase = value.toLowerCase(),
            valid = false;
          this.element.children( "option" ).each(function() {
            if ( $( this ).text().toLowerCase() === valueLowerCase ) {
              this.selected = valid = true;
              return false;
            }
          });
   
          // Found a match, nothing to do
          if ( valid ) {
            return;
          }
   
          // Remove invalid value
          this.input
            .val( "" )
            .attr( "title", value + " didn't match any item" )
            .tooltip( "open" );
          this.element.val( "" );
          this._delay(function() {
            this.input.tooltip( "close" ).attr( "title", "" );
          }, 2500 );
          this.input.autocomplete( "instance" ).term = "";
        },
   
        _destroy: function() {
          this.wrapper.remove();
          this.element.show();
        }
      });
   
      $( "#combobox" ).combobox();
      $( "#toggle" ).on( "click", function() {
        $( "#combobox" ).toggle();
      });
	 */
});

function fn_cityList(cortarNo, depth){
	
	var param = {
		cortarNo : cortarNo,
		depth : depth
	}
	
	$.get("http://localhost:8080/city/list", param, function(result){

		if (depth == 0){
			for ( var i in result ){
				$("#sidoList").append(fn_option(result[i].cortarNo, result[i].cortarName, result[i].depth));	
			}
		} else if (depth == 1){
			for ( var i in result ){
				$("#gugunList").append(fn_option(result[i].cortarNo, result[i].cortarName, result[i].depth));	
			}
		} else {
			for ( var i in result ){
				$("#dongList").append(fn_option(result[i].cortarNo, result[i].cortarName, result[i].depth));	
			}
		}
		
	});
	
}

function fn_option(cortarNo, cortarName, depth){
	return "<option value='" + cortarNo + "' depth='" + depth + "'>" + cortarName + "</option>";
}


// 아파트 리스트
function fn_aptList(dongCode){
	
	if (dongCode){
		
		$.get("http://webserver:8009/apt/list/" + dongCode, function(result){
			
			if (result) {
				
				var parseResult = JSON.parse(decodeURI(result));
				
				if (parseResult.status == 'SUCCESS') {
					
					$("#combobox").empty();

					var aptList = parseResult.result.complexList;
					
					for ( var i in aptList ){
						$("#combobox").append("<option value=" + aptList[i].complexNo + "> " + aptList[i].complexName + "</option>");
					}
					
				}
			}

		});
		
	}
	
	
}

</script>

<body>
	<div class="card-body">
		<div>
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
				<div class="row">
					<div class="col-sm-12 col-md-6">
<!-- 						<div id="dataTable_filter" class="dataTables_filter">
							<label>Search <input type="search" class="form-control" placeholder="" aria-controls="dataTable" style="width: 200px; display: inline-block"></label>
						</div>
						<div class="form-group">
							<select class="form-control-sm" id="sidoList">
								<option>-선택-</option>
							</select>
							<select class="form-control-sm" id="gugunList">
								<option>-선택-</option>
							</select>
							<select class="form-control-sm" id="dongList">
								<option>-선택-</option>
							</select>
						</div>
						<div class="ui-widget">
 							<select id="combobox" class="form-control">

							</select> 
						</div>-->
					</div>
				</div>

			</div>
		</div>
	</div>
</body>
