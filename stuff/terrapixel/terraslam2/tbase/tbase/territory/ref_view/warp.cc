#include "tbase/common.h"

#include <nppcore.h>
#include <nppi.h>

static void call(const cv::cuda::GpuMat& src, cv::cuda::GpuMat& dst, double coeffs[][3], int interpolation, cudaStream_t stream)
{
    static const int npp_inter[] = {NPPI_INTER_NN, NPPI_INTER_LINEAR, NPPI_INTER_CUBIC};

    NppiSize srcsz;
    srcsz.height = src.rows;
    srcsz.width = src.cols;

    NppiRect srcroi;
    srcroi.x = 0;
    srcroi.y = 0;
    srcroi.height = src.rows;
    srcroi.width = src.cols;

    NppiRect dstroi;
    dstroi.x = 0;
    dstroi.y = 0;
    dstroi.height = dst.rows;
    dstroi.width = dst.cols;

    cv::cuda::NppStreamHandler h(stream);

    nppSafeCall( func(src.ptr<npp_type>(), srcsz, static_cast<int>(src.step), srcroi,
                dst.ptr<npp_type>(), static_cast<int>(dst.step), dstroi,
                coeffs, npp_inter[interpolation]) );

    if (stream == 0)
        cudaSafeCall( cudaDeviceSynchronize() );
}
};

