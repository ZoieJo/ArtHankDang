<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl.carousel.js"></script>
<script src="${CONTEXT_PATH}/assets/js/owlcarousel/owl-custom.js"></script>

<style>
#e_img1 {
	width: 50%;
	display: block;
	margin: 0px auto;
}

#id_test1 {
	width: 20%;
	margin-left: 40%;
	margin-right: 40%;
	margin-top: -15%;
    justify-content: center;
}

#j_img1 {
	width: 88%;
}

#owl-carousel-14 {
	width: 20%;
	float: right;
	margin-right: 5%;
}

div.owl-dots {
	display: none;
}
</style>

<div class="col-sm-12">
<div  class="owl-carousel owl-theme owl-loaded owl-drag" id="owl-carousel-14" >
		<div class="owl-stage-outer owl-height">
			<div class="owl-stage" style="transition: all 0.25s ease 0s;">				
				<div id="id_owl" class="owl-item">
					<div class="item" style="">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample1.png" >
					</div>
				</div>	
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample2.png" >
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample3.png" >
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample4.png" >
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample5.png" >
					</div>
				</div>
				<div class="owl-item">
					<div class="item">
						<img id="j_img1" src="${RESOURCES_PATH}/assets/images/slider/sample6.png" >
					</div>
				</div>
			</div>
		</div>
	</div>
<div class="card" style="width: 70%; height: 836px;" >
	<img id="e_img1" src="${RESOURCES_PATH}/assets/images/error/505.png" style="margin-top: 15%;">
	<div class="card-body">
		<a href="${CONTEXT_PATH}"><input id="id_test1" type="button" class="btn btn-primary" value="BACK TO HOME PAGE"></a>
		<div id="basic-1_wrapper" class="dataTables_wrapper no-footer">
		</div>
	</div>
</div>
</div>


<script type="text/javascript">
	$(".owl-carousel").owlCarousel({
		items : 1,
		center : true,
		loop : true,
		dots : true,
		autoplay : true,
		autoplayTimeout : 3000,
		autoplayHoverPause : true,
		rewind : false,
		mouseDrag : true,
		touchDrag : true,
		nav : false
	});
	$(window).on('load scroll resize', function() {
		setTimeout(function() {
			var w = $('.starter-main .owl-carousel.owl-loaded').css('width');
			$('.starter-main .owl-carousel .owl-item .item').css('width', w);
		}, 300);
	});
</script>

