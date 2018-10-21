
window.onload = function () {
    bindDdlProducers();
    bindDdlActors();
    addYears();
};

function addYears() {
    var start = 1980;
    var end = new Date().getFullYear();
    var options = '<option value="">Select</option>';
    for (var year = start; year <= end; year++) {
        options += '<option value="' + year + '">' + year + '</option>';
    }
    document.getElementById("id_ddl_movieyearOfRelease").innerHTML = options;
}
function saveActor() {
    var mode = "Save";
    if (document.getElementById("id_btn_actorSave").innerText.trim() != "Save")
        mode = "Update";

    var actorSex = '';
    var radios = document.getElementsByName("actorgender");
    for (var i = 0; i < radios.length; i++) {
        if (radios[i].checked) {
            actorSex = radios[i].value;
            break;
        }
    }

    var PJson = {
        UID: $('#id_hid_actorID').val().trim(),
        Name: $('#id_txt_actorName').val().trim(),
        Sex: actorSex,
        DOB: $('#id_txt_actorDOB').val().trim(),
        Bio: $('#id_txt_actorBio').val().trim(),
        Mode: mode
    };

    $.ajax({
        type: 'POST',
        url: "/Home/SaveActorDetails",
        data: JSON.stringify(PJson),
        dataType: 'Json',
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            if (result == 1) {
                if (mode == "Save")
                    swal("Saved Successfully", "", "success");
                else
                    swal("Saved Updated", "", "success");

                // fill fresh ddls
                bindDdlProducers();
                bindDdlActors();
                // clear fields
                $('#id_hid_actorID').val("");
                $('#id_txt_actorName').val("");
                $('#id_txt_actorDOB').val("");
                $('#id_txt_actorBio').val("");

                var radios = document.getElementsByName("actorgender");
                $(radios[0]).prop("checked", true);
                document.getElementById("id_btn_actorSave").innerText = "Save";
                $('#id_tbl_displayActorDetails').empty();
            }
            else
                swal("Something went wrong!", "Try Again!", "error");
        },
        error: function (result) {
            swal(result, "Try Again!", "error");
        }
    });
}

function saveProducer() {

    var mode = "Save";
    if (document.getElementById("id_btn_proSave").innerText.trim() != "Save")
        mode = "Update";

    var actorSex = '';
    var radios = document.getElementsByName("progender");
    for (var i = 0; i < radios.length; i++) {
        if (radios[i].checked) {
            actorSex = radios[i].value;
            break;
        }
    }

    var PJson = {
        UID: $('#id_hid_proID').val().trim(),
        Name: $('#id_txt_proName').val().trim(),
        Sex: actorSex,
        DOB: $('#id_txt_proDOB').val().trim(),
        Bio: $('#id_txt_proBio').val().trim(),
        Mode: mode
    };

    $.ajax({
        type: 'POST',
        url: "/Home/SaveProducerDetails",
        data: JSON.stringify(PJson),
        dataType: 'Json',
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            if (result == 1) {
                if (mode == "Save")
                    swal("Saved Successfully", "", "success");
                else
                    swal("Saved Updated", "", "success");

                // fill fresh ddls
                bindDdlProducers();
                bindDdlActors();
                // clear fields
                $('#id_hid_proID').val("");
                $('#id_txt_proName').val("");
                $('#id_txt_proDOB').val("");
                $('#id_txt_proBio').val("");

                var radios = document.getElementsByName("progender");
                $(radios[0]).prop("checked", true);
                document.getElementById("id_btn_proSave").innerText = "Save";
                $('#id_tbl_displayProducerDetails').empty();
            }
            else
                swal("Something went wrong!", "Try Again!", "error");
        },
        error: function (result) {
            swal(result, "Try Again!", "error");
        }
    });
}

function saveMovie() {
    var mode = "Save";
    if (document.getElementById("id_btn_movieSave").innerText.trim() != "Save")
        mode = "Update";

    var multiple = $('#id_ddl_movieActors').val();

    var ActorIds = "";
    for (var i = 0; i < multiple.length; i++) {
        ActorIds += multiple[i] + ",";
    }

    if (ActorIds == "") {
        alert("Please Select atleast 1 Actor");
        return false;
    }

    var formData = new FormData();
    formData.append("UID", $('#id_hid_movieID').val().trim());
    formData.append("Name", $('#id_txt_movieName').val().trim());
    formData.append("YearOfRelease", $('#id_ddl_movieyearOfRelease option:selected').val().trim());
    formData.append("Producer", $('#id_ddl_movieProducer option:selected').val());
    formData.append("Actors", ActorIds.substring(0, ActorIds.length - 1));
    formData.append("Plot", $('#id_txt_moviePlot').val().trim());
    formData.append("PosterFile", $("#id_file_moviePoster")[0].files[0]);
    formData.append("Mode", mode);

    $.ajax({
        type: 'POST',
        url: "/Home/SaveMovieDetails",
        data: formData,
        dataType: 'json',
        contentType: false,
        processData: false,
        success: function (result) {
            if (result == 1) {
                if (mode == "Save")
                    swal("Saved Successfully", "", "success");
                else
                    swal("Saved Updated", "", "success");
                // clear fields
                $('#id_hid_movieID').val("");
                $('#id_txt_movieName').val("");
                $('#id_txt_movieyearOfRelease option:selected').val("");
                bindDdlProducers();
                bindDdlActors();

                $('#id_txt_moviePlot').val("");
                $('#id_file_moviePoster').val("");

                document.getElementById("id_btn_movieSave").innerText = "Save";
                $('#id_tbl_displayMovieDetails').empty();
            }
            else
                swal("Something went wrong!", "Try Again!", "error");
        },
        error: function (result) {
            swal(result, "Try Again!", "error");
        }
    });
}

// searching 
var globalJson = {};

function searchActor() {
    $.ajax({
        type: 'GET',
        url: "/Home/SearchActorDetails",
        data: {
            Name: $('#id_txt_actorSearch').val().trim()
        },
        dataType: 'Json',
        contentType: "application/json; charset=utf-8",
        success: function (res) {
            if (res != "") {
                globalJson = res;
                $('#id_tbl_displayActorDetails').empty();
                for (var i = 0; i < res.length; i++) {
                    t = '<tr>';
                    t += '<td style="width:70px">' + (parseInt(i) + 1) + '</td>';
                    t += '<td>' + res[i].Name + '</td>';
                    t += '<td>' + res[i].Sex + '</td>';
                    t += '<td>' + res[i].DOB + '</td>';
                    t += '<td>' + res[i].Bio + '</td>';
                    t += '<td>' + '<button type="button" class="btn btn-success btn-sm" onclick="editActorDetail(this.id)" id=actor_' + res[i].UID + '> EDIT </button></td>';
                    t += '</tr>';
                    $('#id_tbl_displayActorDetails').append(t);
                }
            }
            else {
                swal("error", "Oops ! There is No Record for this Search", "error");
                $('#id_tbl_displayActorDetails').empty();
            }
        },
        error: function (da) {
            alert('Error');
        }
    });
}

function searchProducer() {
    $.ajax({
        type: 'GET',
        url: "/Home/SearchProducerDetails",
        data: {
            Name: $('#id_txt_proSearch').val().trim()
        },
        dataType: 'Json',
        contentType: "application/json; charset=utf-8",
        success: function (res) {
            if (res != "") {
                globalJson = res;
                $('#id_tbl_displayProducerDetails').empty();
                for (var i = 0; i < res.length; i++) {
                    t = '<tr>';
                    t += '<td style="width:70px">' + (parseInt(i) + 1) + '</td>';
                    t += '<td>' + res[i].Name + '</td>';
                    t += '<td>' + res[i].Sex + '</td>';
                    t += '<td>' + res[i].DOB + '</td>';
                    t += '<td>' + res[i].Bio + '</td>';
                    t += '<td>' + '<button type="button" class="btn btn-success btn-sm" onclick="editProducerDetail(this.id)" id=pro_' + res[i].UID + '> EDIT </button></td>';
                    t += '</tr>';
                    $('#id_tbl_displayProducerDetails').append(t);
                }
            }
            else {
                swal("error", "Oops ! There is No Record for this Search", "error");
                $('#id_tbl_displayProducerDetails').empty();
            }
        },
        error: function (da) {
            alert('Error');
        }
    });
}

function searchMovie() {
    $.ajax({
        type: 'GET',
        url: "/Home/SearchMovieDetails",
        data: {
            Name: $('#id_txt_movieSearch').val().trim()
        },
        dataType: 'Json',
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data != "") {
                var res = [];

                // catch Movies with same UID but with different Actors

                var duplicate = [];
                for (var p = 0; p < data.length; p++) {
                    var flag = 0;
                    var duplicateId = -1;

                    for (var k = 0; k < duplicate.length; k++) {
                        if (res[k].UID == data[p].UID) {
                            flag = 1;
                            duplicateId = k;
                            break;
                        }
                    }

                    if (flag == 1) {
                        res[k].Actors = res[k].Actors + ", " + data[p].Actors;
                    }
                    else {
                        duplicate.push(p);
                        res.push(data[p]);
                    }
                }
                globalJson = res;
                $('#id_tbl_displayMovieDetails').empty();
                for (var i = 0; i < res.length; i++) {
                    t = '<tr>';
                    t += '<td>' + (parseInt(i) + 1) + '</td>';
                    t += '<td>' + res[i].Name + '</td>';
                    t += '<td>' + res[i].YearOfRelease + '</td>';
                    t += '<td>' + res[i].Producer + '</td>';
                    t += '<td>' + res[i].Actors + '</td>';
                    t += '<td>' + res[i].Plot + '</td>';
                    t += '<td>' + '<button type="button" class="btn btn-success btn-sm" onclick="editMovieDetail(this.id)" id=movie_' + res[i].UID + '> EDIT </button></td>';
                    t += '</tr>';
                    $('#id_tbl_displayMovieDetails').append(t);
                }
            }
            else {
                swal("error", "Oops ! There is No Record for this Search", "error");
                $('#id_tbl_displayMovieDetails').empty();
            }
        },
        error: function (da) {
            alert('Error');
        }
    });
}

function editActorDetail(actorId) {
    $('#id_hid_actorID').val(actorId.substring(6, actorId.length));
    document.getElementById("id_btn_actorSave").innerText = "Update";
    var indexInGlobalJson = -1;

    for (var i = 0; i < globalJson.length; i++) {
        if (globalJson[i]["UID"] == actorId.substring(6, actorId.length)) {
            indexInGlobalJson = i;
            break;
        }
    }
    var actorDOB = globalJson[indexInGlobalJson]["DOB"];
    $('#id_txt_actorName').val(globalJson[indexInGlobalJson]["Name"]);
    $('#id_txt_actorDOB').val(actorDOB.substring(0, actorDOB.length - 12));
    $('#id_txt_actorBio').val(globalJson[indexInGlobalJson]["Bio"]);
    // select gender radio button
    var radios = document.getElementsByName("actorgender");
    for (var i = 0; i < radios.length; i++) {
        if (radios[i].value == globalJson[indexInGlobalJson]["Sex"]) {
            $(radios[i]).prop("checked", true);
            break;
        }
    }
}

function editProducerDetail(proId) {
    $('#id_hid_proID').val(proId.substring(4, proId.length));
    document.getElementById("id_btn_proSave").innerText = "Update";
    var indexInGlobalJson = -1;

    for (var i = 0; i < globalJson.length; i++) {
        if (globalJson[i]["UID"] == proId.substring(4, proId.length)) {
            indexInGlobalJson = i;
            break;
        }
    }
    var proDOB = globalJson[indexInGlobalJson]["DOB"];
    $('#id_txt_proName').val(globalJson[indexInGlobalJson]["Name"]);
    $('#id_txt_proDOB').val(proDOB.substring(0, proDOB.length - 12));
    $('#id_txt_proBio').val(globalJson[indexInGlobalJson]["Bio"]);
    // select gender radio button
    var radios = document.getElementsByName("progender");
    for (var i = 0; i < radios.length; i++) {
        if (radios[i].value == globalJson[indexInGlobalJson]["Sex"]) {
            $(radios[i]).prop("checked", true);
            break;
        }
    }
}

function editMovieDetail(movieId) {
    $('#id_hid_movieID').val(movieId.substring(6, movieId.length));
    document.getElementById("id_btn_movieSave").innerText = "Update";
    var indexInGlobalJson = -1;

    for (var i = 0; i < globalJson.length; i++) {
        if (globalJson[i]["UID"] == movieId.substring(6, movieId.length)) {
            indexInGlobalJson = i;
            break;
        }
    }

    $('#id_txt_movieName').val(globalJson[indexInGlobalJson]["Name"]);
    $('#id_ddl_movieyearOfRelease option:contains(' + globalJson[indexInGlobalJson]["YearOfRelease"] + ')').attr('selected', 'selected');
    //$('#id_ddl_movieProducer option:contains(' + globalJson[indexInGlobalJson]["Producer"] + ')').attr('selected', 'selected');
    $('#id_txt_moviePlot').val(globalJson[indexInGlobalJson]["Plot"]);

    //var actorName = globalJson[indexInGlobalJson]["Actors"].split(', ');

    //for (var i = 0; i < actorName.length; i++) {
    //    $('#id_ddl_movieActors option:contains(' + actorName[i] + ')').attr('selected', 'selected');
    //}
    //$('#id_ddl_movieActors').selectpicker('refresh');
}

// fill ddls from database 

function bindDdlActors() {
    $.get("/Home/BindDDLActors", function (data) {
        var option = "";
        $('#id_ddl_movieActors').empty();
        var option = '<option value="">Select</option>';
        for (i = 0; i < data.length; i++) {
            option += '<option value="' + data[i]["UID"] + '">' + data[i]["Name"] + '</option>';
        }
        $('#id_ddl_movieActors').append(option).selectpicker('refresh');
    });
}

function bindDdlProducers() {
    $.get("/Home/BindDDLProducers", function (data) {
        var option = "";
        $('#id_ddl_movieProducer').empty();
        var option = '<option value="">Select</option>';
        for (i = 0; i < data.length; i++) {
            option += '<option value="' + data[i]["UID"] + '">' + data[i]["Name"] + '</option>';
        }

        $('#id_ddl_movieProducer').append(option);
    });
}