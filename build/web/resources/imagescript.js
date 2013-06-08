/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var imgCount=0;
var flips = [0,0,0,0,0,0,0,0,0,0];
var keyArray = [];
var valueArray = [];

function setDummyImages(keys, values){
    keyArray = keys;
    valueArray = values;
    for(var i=0; i<keys.length; i++){
        var dimgId = "dimg"+i;
        var dnimgId="dnimg"+i;
        document.getElementById(dimgId).src="resources/"+keys[i]+".jpg";
        document.getElementById(dnimgId).src="resources/"+values[i]+".jpg";
    }
    
}

function setImages(keys, values){
    keyArray = keys;
    valueArray = values;
    for(var i=0; i<keys.length; i++){
        var imgId = "img"+i;
        document.getElementById(imgId).src="resources/"+keys[i]+".jpg";
    }
    
}
function showImage(i){
    if(flips[i]!=1){
        imgCount++;
        var imgId = "img"+i;
        if(imgCount>2){
            clearInterval(imgTimer);
            for(var k=0; k<10; k++){
                if(flips[k]==1)
                    hideImage(k);
            }
        }
        flips[i]=1;
        document.getElementById(imgId).src="resources/"+valueArray[i]+".jpg";

        if(imgCount==2){
            var check;
            var checkTimer = setInterval(function(){
                clearInterval(checkTimer);
                check= checkImages();
            }, 50);
            
            if(!check){
                var second=0, seconds=1;
                var imgTimer = setInterval(function(){
                    if(second>=seconds){
                        clearInterval(imgTimer);
                        for(var k=0; k<10; k++){
                            if(flips[k]==1){
                                hideImage(k);
                            }
                        }
                    }
                    second++;
                }, 150);
            }
        }
    }
            
                
}

function checkImages(){
    var checkImgs = new Array(2);
    var index = 0;
    for(var k=0; k<10; k++){
        if(flips[k]==1){
            checkImgs[index] = k;
            index++;
        }
    }
    if(valueArray[checkImgs[0]]==valueArray[checkImgs[1]]){
        imgCount = imgCount-2;
        //$(#)
        var img0 = "img"+checkImgs[0];
        var img1 = "img"+checkImgs[1];
        document.getElementById(img0).src="resources/tick.jpg";
        document.getElementById(img1).src="resources/tick.jpg";
        $("#"+img0).hide();
        $("#"+img1).hide();
        flips[checkImgs[0]] = 2;
        flips[checkImgs[1]] = 2;
        score = score+100+(40-count);
        return true;
    }
    else
        return false;
}

function hideImage(j){
    imgCount--;
    var imgId = "img"+j;
    flips[j]=0;
    document.getElementById(imgId).src="resources/"+keyArray[j]+".jpg";
}

function setSeed(seed){
    keys1.push("aaple","banana","clouds","deer","dog","eagle","light","tea","train","zebra");
    values1.push(1,2,3,4,5,1,2,3,4,5);
    keys2.push("aaple","banana","clouds","deer","dog","eagle","light","tea","train","zebra");
    values2.push(1,2,3,4,5,1,2,3,4,5);
    var temp1, temp2;
    for(var i=0; i<10; i++){
        temp1 = keys2[parseInt(seed.substr(i,1))];
        keys2[parseInt(seed.substr(i,1))] = keys2[i];
        keys2[i] = temp1;
                         
        temp2 = values2[parseInt(seed.substr(i,1))];
        values2[parseInt(seed.substr(i,1))] = values2[i];
        values2[i] = temp2;
    }
}