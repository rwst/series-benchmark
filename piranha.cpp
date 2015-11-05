#define BENCHPRESS_CONFIG_MAIN                                                    
#include <cstddef>                                                                
#include <benchpress/benchpress.hpp>
//#include "series-benchmark.h"

#include <string>
#include <iostream>
#include <tuple>
#include <type_traits>

#include <piranha/monomial.hpp>
#include <piranha/polynomial.hpp>
#include <piranha/mp_rational.hpp>
#include <piranha/mp_integer.hpp>

using namespace piranha;
using pt = polynomial<rational,monomial<short>>;

benchpress::auto_register CONCAT2(register_, __LINE__)(("piranha"),
    ([](benchpress::context* ctx) {
    
//    pt::set_auto_truncate_degree(1000);
    
    pt psin{0}, pcos{1}, x{"x"}, p;
    integer prod{1};
    
    for (unsigned int i=0; i<100; i++) {
        const short j = 2*i + 1;
        if (i != 0)
            prod *= 1-j;
        prod *= j;
        psin += rational{1,prod} * x.pow(j);
    }

    prod = 1;
    for (unsigned int i=1; i<100; i++) {
        const short j = 2*i;
        prod *= 1-j;
        prod *= j;
        pcos += rational{1,prod} * x.pow(j);
    }
    
    ctx->reset_timer();
    ctx->start_timer();
    for (size_t i = 0; i < ctx->num_iterations(); ++i)
        p = psin * pcos;
    ctx->stop_timer();
}));



