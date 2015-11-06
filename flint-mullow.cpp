#define BENCHPRESS_CONFIG_MAIN
#include <cstddef>
#include <flint/fmpq_poly.h>
#include <benchpress/benchpress.hpp>
#include "series-benchmark.h"

    benchpress::auto_register CONCAT2(register_, __LINE__)(("flint"),
    ([](benchpress::context* ctx) {
        fmpq_poly_t x, y, z;
        fmpq_poly_init (x);
        fmpq_poly_init (y);
        fmpq_poly_init (z);
        fmpq_poly_set_coeff_ui(x, 1, 1);
        fmpq_poly_sin_series(x, x, N);
        fmpq_poly_set_coeff_ui(y, 1, 1);
        fmpq_poly_cos_series(y, y, N);
        ctx->reset_timer();
        ctx->start_timer();
        for (size_t i = 0; i < ctx->num_iterations(); ++i) {
            //fmpq_poly_mullow (z , x , y, N) ;
            fmpq_poly_mul (z , x , y) ;
        }
        ctx->stop_timer();
        fmpq_poly_clear (x);
        fmpq_poly_clear (y);
        fmpq_poly_clear (z);
    }));

