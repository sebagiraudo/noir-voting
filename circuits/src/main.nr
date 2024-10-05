use dep::std;

fn main(comms_list: pub [Field; 4 ], index: Field, secret: Field) {
    let commitment = std::hash::pedersen_hash([secret]);
    assert(comms_list[index] == commitment);
}

#[test]
fn main_test() {
    let comm_1 = std::hash::pedersen_hash([1]);
    let comm_2 = std::hash::pedersen_hash([2]);
    let comm_3 = std::hash::pedersen_hash([3]);
    let comm_4 = std::hash::pedersen_hash([4]);

    let commitments_list = [comm_1, comm_2, comm_3, comm_4]; 

    for i in 0..4 {
        std::println(commitments_list[i]);
    }
    // For User 1
    main(commitments_list, 0, 1);

    // For User 2
    main(commitments_list, 1, 2);
}