#include "tbase/territory/ref_view/ref_view.h"

template <typename MatType>
MatType myWarpPerspective(MatType img, const SE3f& ww, const cv::Size& outSize, float f_mult) {
    int w = img.cols, h = img.rows;
    /*
    float fx = f_mult / img.cols;
    float fy = f_mult / img.rows;
    float fx2_i = outSize.width / f_mult;
    float fy2_i = outSize.height / f_mult;
    */
    float fy, fy2_i;
    float fx = fy = 1./f_mult;
    float fx2_i = fy2_i = f_mult;

    Eigen::Matrix4d warp = ww.matrix().cast<double>();

    Eigen::Matrix<double, 4,3> flatten0; // Converts pixel coords to calibrated, centered, coords
    Eigen::Matrix<double, 3,4> flatten; // Converts calib/centered to pixel coords w.r.t outSize.
    flatten0 <<
        fx, 0, -fx*w/2,
        0, fy, -fy*h/2,
        0, 0, 0   ,
        0, 0, 1   ;
    flatten <<
        fx2_i*outSize.width/2, 0, outSize.width/2, 0,
        0, fy2_i*outSize.width/2, outSize.height/2, 0,
        0, 0, 1,   0;

    Eigen::Matrix<double, 3,3> flat = flatten * warp * flatten0;

    cv::Mat m(3,3, CV_64F);
    for (int i=0; i<3; i++) for (int j=0; j<3; j++) m.at<double>(i,j) = flat(i,j);

    MatType wimg;


    //auto b = cv::BORDER_REPLICATE;
    auto b = cv::BORDER_CONSTANT;

    if (std::is_same<MatType, cv::cuda::GpuMat>::value)
        cv::cuda::warpPerspective(img,wimg, m, outSize, cv::INTER_LINEAR, b);
    else
        cv::warpPerspective(img,wimg, m, outSize, cv::INTER_LINEAR, b);

    return wimg;
}

template <typename MatType>
ReferenceView<MatType>::ReferenceView(const MatType& mat, const SE3t& base, float wfx, float wfy)
  : base(base), baseView(mat), wfx(wfx),wfy(wfy)
{
  assert(wfx == wfy);
}

template <typename MatType>
MatType ReferenceView<MatType>::localView(SE3t local, float fx, float fy, cv::Size outSize) {
  //assert(fx == wfx and fy == wfy);

  //local = local * base;

  MatType view = myWarpPerspective(baseView, local, outSize, fx * wfx);

  return view;
}

template <typename MatType>
MatType ReferenceView<MatType>::worldView(SE3t world, float fx, float fy, cv::Size outSize) {
  //assert(fx == wfx and fy == wfy);

  // Undo the base transform to get the view matrix we want!
  SE3t local = base.inverse() * world;
  //SE3t local = base * world.inverse();

  MatType view = myWarpPerspective(baseView, local, outSize, fx * wfx);

  return view;
}

template class ReferenceView<cv::Mat>;
template class ReferenceView<cv::cuda::GpuMat>;
