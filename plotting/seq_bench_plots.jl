using Makie

const XLabels = ["Seq", "BioJulia", "Simple", "BioID"]
const XColors = [:red, :blue, :green, :orange]
const AxisNames = ("Language", "Mean time (microseconds)")

# 16_mer benchmark results
t16_mer = [
    [11.24, 11.03, 10.89, 11.43, 11.07],
    [33.98, 33.34, 32.39, 32.68, 34.92],
    [4.49, 4.44, 4.47, 4.58, 4.86],
    [34.00, 34.40, 33.66, 34.58, 34.61]
]
t16 = Scene(resolution = (500, 500))
barplot!(t16, XLabels, [sum(v) / length(v) for v in t16_mer], color = XColors)
axis = t16[Axis]
axis.names.axisnames = AxisNames
axis.ticks.title_gap = 10
center!(t16)
save("16mer-benchmarks.png", t16)

# CpG benchmark results
tcpg = [
    [8.78, 8.75, 9.20, 9.19, 9.42],
    [35.06, 35.05, 35.28, 35.57, 34.55],
    [3.04, 3.09, 3.05, 3.04, 3.06],
    [32.23, 32.40, 32.17, 32.49, 32.16]
]
tcpg_scene = Scene(resolution = (500, 500))
barplot!(tcpg_scene, XLabels, [sum(v) / length(v) for v in tcpg], color = XColors)
axis = tcpg_scene[Axis]
axis.names.axisnames = AxisNames
axis.ticks.title_gap = 10
center!(tcpg_scene)
save("cpg-benchmarks.png", tcpg_scene)

# Reverse complement benchmark results
trc = [
    [5.25, 5.48, 5.27, 5.23, 5.15],
    [47.48, 48.86, 48.83, 47.34, 46.36],
    [5.83, 5.87, 5.94, 5.80, 6.00],
    [44.92, 44.68, 45.09, 44.75, 45.66]
]
rc_scene = Scene(resolution = (500, 500))
barplot!(rc_scene, XLabels, [sum(v) / length(v) for v in trc], color = XColors)
axis = rc_scene[Axis]
axis.names.axisnames = AxisNames
axis.ticks.title_gap = 10
center!(rc_scene)
save("rc-benchmarks.png", rc_scene)