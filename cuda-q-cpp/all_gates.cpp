#include <cudaq.h>

struct basic_gates_example{

    __qpu__ void operator()() {

      cudaq::qvector q(2);
      h(q[0]);  // Hadamard gate on the first qubit
      x(q[0]);  // Pauli-X gate on the first qubit
      y(q[1]);  // Pauli-Y gate on the second qubit
      z(q[1]);  // Pauli-Z gate on the second qubit
      x<cudaq::ctrl>(q[0], q[1]);
      mz(q);
    }
};

int main() {
    auto counts = cudaq::sample(100, basic_gates_example{});

    if (!cudaq::mpi::is_initialized() || cudaq::mpi::rank() == 0) {
      counts.dump();

    // Fine grain access to the bits and counts
    for (auto &[bits, count] : counts) {
      printf("Observed: %s, %lu\n", bits.data(), count);
    }
  }
    return 0;
}





