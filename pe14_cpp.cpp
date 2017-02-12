/*
 * pe14_cpp.cpp
 * Using awful templates... why not.
 * This solution does not check all numbers up to 1000000 (see note at bottom).
 * Author: Michael Quigley
 */
#include <iostream>

#define CHAIN_COUNT_PARAM(N) (N), ((N) % 2)

template <long n, long is_odd>
struct ChainCount;

template <long n>
struct MaxCollatz;

// The is_odd recursive case.
template <long n>
struct ChainCount<n, 1> {
  enum : long { result = 1 + ChainCount<CHAIN_COUNT_PARAM(n * 3 + 1)>::result };
};

// The !is_odd recursive case.
template <long n>
struct ChainCount<n, 0> {
  enum : long { result = 1 + ChainCount<CHAIN_COUNT_PARAM(n / 2)>::result };
};

// Base case specialization.
template <>
struct ChainCount<1, 1> {
  enum : long { result = 0 };
};

// MaxCollatz recursive case.
template <long n>
struct MaxCollatz {
  enum : long {
    best_count =
        MaxCollatz<n - 1>::best_count > ChainCount<CHAIN_COUNT_PARAM(n)>::result
            ? MaxCollatz<n - 1>::best_count
            : ChainCount<CHAIN_COUNT_PARAM(n)>::result,
    best_num =
        MaxCollatz<n - 1>::best_count > ChainCount<CHAIN_COUNT_PARAM(n)>::result
            ? MaxCollatz<n - 1>::best_num
            : n
  };
};

// Base case specialization.
template <>
struct MaxCollatz<1> {
  enum : long { best_count = 0, best_num = 1 };
};

int main() {
  // NOTE: max_num isn't being set to 1000000 like in the other solutions. This
  // is because even when the maximum template depth is set to a sufficiently
  // high number (-ftemplate-depth-1000000), both g++ 4.9 and clang++ 3.9
  // segfault.
  const long max_num = 1000;
  std::cout << "Resulting number is " << MaxCollatz<max_num>::best_num
            << ", max count is " << MaxCollatz<max_num>::best_count
            << std::endl;
  return 0;
}
