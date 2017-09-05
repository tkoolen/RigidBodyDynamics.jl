__precompile__()

module RigidBodyDynamics

using Base.Random
using StaticArrays
using Rotations
using TypeSortedCollections
using LightXML
using DocStringExtensions
using Compat
import Base.Iterators: filter, flatten

export
    # types
    CartesianFrame3D,
    Transform3D,
    Point3D,
    FreeVector3D,
    SpatialInertia,
    RigidBody,
    Joint,
    GenericJoint,
    JointType,
    QuaternionFloating,
    Revolute,
    Prismatic,
    Fixed,
    Planar,
    QuaternionSpherical,
    Twist,
    GeometricJacobian,
    Wrench,
    WrenchMatrix,
    Momentum,
    MomentumMatrix,
    SpatialAcceleration,
    Mechanism,
    MechanismState,
    DynamicsResult,
    # functions
    rotation,
    translation,
    has_defined_inertia,
    default_frame,
    frame_before,
    frame_after,
    joint_type,
    add_frame!,
    transform,
    newton_euler,
    torque,
    joint_torque!,
    point_velocity,
    local_coordinates!,
    global_coordinates!,
    root_frame,
    root_body,
    non_root_bodies,
    isroot,
    bodies,
    path,
    joints,
    tree_joints,
    successor,
    predecessor,
    in_joints,
    out_joints,
    joints_to_children,
    joint_to_parent,
    configuration_derivative,
    velocity_to_configuration_derivative!,
    configuration_derivative_to_velocity!,
    configuration_derivative_to_velocity_adjoint!,
    num_positions,
    num_velocities,
    num_constraints,
    isfloating,
    num_additional_states,
    num_bodies,
    configuration,
    configuration_range,
    velocity,
    velocity_range,
    additional_state,
    joint_transform,
    motion_subspace,
    motion_subspace_in_world,
    constraint_wrench_subspace,
    has_fixed_subspaces,
    bias_acceleration,
    spatial_inertia,
    spatial_inertia!,
    add_contact_point!,
    contact_points,
    crb_inertia,
    setdirty!,
    add_body_fixed_frame!,
    fixed_transform,
    attach!,
    remove_joint!,
    replace_joint!,
    maximal_coordinates,
    submechanism,
    remove_fixed_tree_joints!,
    add_environment_primitive!,
    rand_mechanism,
    rand_chain_mechanism,
    rand_tree_mechanism,
    rand_floating_tree_mechanism,
    state_vector, # TODO: Base.convert method to Vector?
    rand_configuration!,
    zero_configuration!,
    rand_velocity!,
    zero_velocity!,
    set_configuration!,
    set_velocity!,
    set_additional_state!,
    set!,
    zero!,
    add_frame!,
    twist_wrt_world,
    relative_twist,
    transform_to_root,
    relative_transform,
    mass,
    center_of_mass,
    geometric_jacobian,
    geometric_jacobian!,
    relative_acceleration,
    kinetic_energy,
    gravitational_potential_energy,
    spatial_accelerations!,
    mass_matrix!,
    mass_matrix,
    momentum,
    momentum_matrix!,
    momentum_matrix,
    momentum_rate_bias,
    inverse_dynamics!,
    inverse_dynamics,
    dynamics_bias!,
    dynamics_bias,
    dynamics!,
    parse_urdf,
    simulate,
    findbody,
    findjoint,
    body_fixed_frame_to_body,
    position_bounds,
    velocity_bounds,
    effort_bounds,
    # macros
    @framecheck

const noalloc_doc = """This method does its computation in place, performing no dynamic memory allocation."""

include("custom_collections.jl")
include("graphs.jl")

using .CustomCollections # TODO
include("cache_element.jl")

function name end # TODO
function translation end # TODO
function rotation end # TODO
function transform end # TODO
function center_of_mass end # TODO
function newton_euler end # TODO
function kinetic_energy end # TODO
include("spatial/Spatial.jl")
using .Spatial # TODO

include("util.jl")
include("contact.jl")

include("joint_types.jl")
include("joint.jl")

using .Contact # TODO
include("rigid_body.jl")

using .Graphs # TODO
include("mechanism.jl")
include("mechanism_modification.jl")
include("mechanism_state.jl")
include("dynamics_result.jl")
include("mechanism_algorithms.jl")
include("parse_urdf.jl")
include("ode_integrators.jl")
include("simulate.jl")

end # module
