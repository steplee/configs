#include "tbase/common.h"


// TODO implement second version without opencv; use cuda texture and sampler.

template <class MatType>
class ReferenceView {

  public:
    ReferenceView(const MatType& mat, const SE3t& base, float wfx=1., float wfy=1.);

    // Will rotate around origin, probably not want you want, so use world view instead.
    MatType localView(SE3t local, float fx, float fy, cv::Size outSize);
    MatType worldView(SE3t world, float fx, float fy, cv::Size outSize);

  private:
    const SE3t base;
    const MatType baseView;
    const float wfx,wfy;

};
