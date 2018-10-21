
window.onload = function () {
    getMovie();
};


function getMovie() {
    $.get("/Home/DisplayMoviesPosters", function (data) {
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
            $('#id_div_displayMovies').empty();
            var t = '<div class="row">';

            for (var i = 0; i < res.length; i++) {
                if (i % 4 == 0 && i > 0) {
                    t += '</div><div class="row">'
                }
                t += '<div class="col-md-3 col-sm-6"><div class="person">';
                t += '<img src="/Content/MoviePosters/' + res[i].PosterFile + '" alt="" class="img-responsive" style="height:250px;width:300px" />';
                t += '<div class="person-content">';
                t += '<h4><strong>' + res[i].Name + '</strong></h4>';
                t += '<p><b>Year Of Release : </b>' + res[i].YearOfRelease + '<br>';
                t += '<b>Producer : </b>' + res[i].Producer + '<br>';
                t += '<b>Description : </b><br><span style="text-align:justify">' + res[i].Plot.substring(0, 150) + '<br>';
                t += '</span></p></div></div></div>';
            }
            $('#id_div_displayMovies').append(t + '</div>');
        }
        else {
            $('#id_div_displayMovies').append("<h2> No Movie Found, Add Movies to see them here !");
        }
    });
}

