use dep::std;

fn main(root : pub Field, index : Field, hash_path : [Field; 2], secret: Field) {
    let note_commitment = std::hash::pedersen_hash([secret]);

    let check_root = std::merkle::compute_merkle_root(note_commitment, index, hash_path);
    assert(root == check_root);
}

#[test]
fn test_valid_build_merkle_tree() {
    let commitment_0 =  std::hash::pedersen_hash([1]);
    let commitment_1 =  std::hash::pedersen_hash([2]);
    let commitment_2 =  std::hash::pedersen_hash([3]);
    let commitment_3 =  std::hash::pedersen_hash([4]);

    let left_branch = std::hash::pedersen_hash([commitment_0, commitment_1]);
    let right_branch = std::hash::pedersen_hash([commitment_2, commitment_3]);

    let root = std::hash::pedersen_hash([left_branch, right_branch]);

    main(
        root,
        0,
        [commitment_1, right_branch],
        1
    );
}