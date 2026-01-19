import numpy as np
import json
import pandapower as pp
import matplotlib.pyplot as plt

# Base power
Sbase = 1.0  # MVA

net = pp.create_empty_network()


Vbase_kV = 1.0
Zbase_ohm = (Vbase_kV**2) / Sbase

bus = {}
for i in range(0, 5):
    bus[i] = pp.create_bus(net, vn_kv=Vbase_kV, name=f"Bus {i}")

# Slack at bus 1
pp.create_ext_grid(net, bus[0], vm_pu=1, va_degree=0.0)

def add_pu_reactance_line(i, j, Xpu):
    Xohm = Xpu * Zbase_ohm
    pp.create_line_from_parameters(
        net,
        from_bus=bus[i],
        to_bus=bus[j],
        length_km=1.0,
        r_ohm_per_km=0.0,
        x_ohm_per_km=float(Xohm),
        c_nf_per_km=0.0,
        max_i_ka=1e9
    )

pp.create.create_gen(net, bus[1], p_mw=0.2)
pp.create.create_gen(net, bus[2], p_mw=0.5)

add_pu_reactance_line(0, 3, 0.1)
add_pu_reactance_line(1, 3, 0.2)
add_pu_reactance_line(2, 4, 0.5)
add_pu_reactance_line(3, 4, 0.5)

pp.create_load(net, bus[3], p_mw=0.7*Sbase, q_mvar=0.08*Sbase, name="Load bus 4")
pp.create_load(net, bus[4], p_mw=0.2*Sbase, q_mvar=0.02*Sbase, name="Load bus 5")

# Solve powerflow
pp.runpp(net, algorithm="nr", init="flat")

# Print loop
for i in range(5):
    p = net.res_bus.loc[bus[i], "p_mw"]
    q = net.res_bus.loc[bus[i], "q_mvar"]
    vm = net.res_bus.loc[bus[i], "vm_pu"]
    va = net.res_bus.loc[bus[i], "va_degree"]
    V = vm * np.exp(1j*np.deg2rad(va))
    print(f"Bus {i+1}: p={p} q={q} vm_pu={vm:.8f}, va_deg={va:.8f}")

# Plotting
ax = pp.plotting.simple_plot(net,
    plot_loads=True,
    plot_gens=True,
    show_plot=False
)

for bus_idx in net.bus.index:
    geo = net.bus.at[bus_idx, "geo"]
    if geo is None or (isinstance(geo, float) and np.isnan(geo)):
        continue

    # geo can be dict already or a JSON string depending on version
    if isinstance(geo, str):
        geo = json.loads(geo)

    x, y = geo["coordinates"]
    ax.text(x, y + 0.02, f"Bus {bus_idx+1}", fontsize=10, ha="center", va="bottom")

plt.show()

