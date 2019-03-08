#include "tbase/territory/ref_view/ref_view.h"
#include <cmath>




int main() {

  cv::Mat src = cv::imread("/data/khop/FortCampbell.jpg");
  src = src(cv::Rect{1800,0,2048,2048});
  cv::imwrite("rv_src.jpg",src);

  cv::Size os(512,512);
  cv::resize(src,src,os);

  ReferenceView<cv::Mat> rv_full(src, x);

  auto rv_full_lv = rv_full.localView(SE3t::transZ(.0), fx,fx,os);
  cv::imwrite("rv_lv.jpg", rv_full_lv);

  auto x2 = SE3t::transZ(1.0);
  auto rv_full_wv = rv_full.worldView(x2, fx,fx,os);
  cv::imwrite("rv_full_wv_z1.jpg", rv_full_wv);

  auto x3 = SE3t::transZ(2.0);
  auto rv_full_wv2 = rv_full.worldView(x3, fx,fx,os);
  cv::imwrite("rv_full_wv_z2.jpg", rv_full_wv2);

  auto x4 = SE3t::transZ(3.0);
  auto rv_full_wv3 = rv_full.worldView(x4, fx,fx,os);
  cv::imwrite("rv_full_wv_z3.jpg", rv_full_wv3);


  for (double rx=0; rx<1.41; rx+=.1) {
    auto xx = SE3t::rotX(-rx) * SE3t::transZ(z);
    auto rv_rot = rv_full.worldView(xx, fx,fx,os);
    cv::imwrite("rv_lv"+std::to_string(rx)+".jpg", rv_rot);
  }
}
