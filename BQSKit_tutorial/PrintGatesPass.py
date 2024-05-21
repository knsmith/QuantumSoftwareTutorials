from bqskit.compiler import BasePass, PassData
from bqskit import Circuit

class PrintGatesPass(BasePass):
    async def run(self, circuit: Circuit, data: PassData) -> None:
        print(circuit.gate_counts)