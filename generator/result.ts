export type Integer7Bd9WOt2 = number;
export type StringDoaGddGA = string;
export interface ObjectOfStringDoaGddGAStringDoaGddGAInteger7Bd9WOt2Vn8VJwJm {
    id: Integer7Bd9WOt2;
    name: StringDoaGddGA;
    tag?: StringDoaGddGA;
    [k: string]: any;
}
export type IntegerOmVsfaNv = number;
export type UnorderedSetOfObjectOfStringDoaGddGAStringDoaGddGAInteger7Bd9WOt2Vn8VJwJmpOQ3LGMI = ObjectOfStringDoaGddGAStringDoaGddGAInteger7Bd9WOt2Vn8VJwJm[];
/**
 *
 * Generated! Represents an alias to any of the provided schemas
 *
 */
export type AnyOfIntegerOmVsfaNvStringDoaGddGAStringDoaGddGAInteger7Bd9WOt2UnorderedSetOfObjectOfStringDoaGddGAStringDoaGddGAInteger7Bd9WOt2Vn8VJwJmpOQ3LGMIInteger7Bd9WOt2ObjectOfStringDoaGddGAStringDoaGddGAInteger7Bd9WOt2Vn8VJwJm = IntegerOmVsfaNv | StringDoaGddGA | Integer7Bd9WOt2 | UnorderedSetOfObjectOfStringDoaGddGAStringDoaGddGAInteger7Bd9WOt2Vn8VJwJmpOQ3LGMI | ObjectOfStringDoaGddGAStringDoaGddGAInteger7Bd9WOt2Vn8VJwJm;
export type ListPets = (limit?: IntegerOmVsfaNv) => Promise<UnorderedSetOfObjectOfStringDoaGddGAStringDoaGddGAInteger7Bd9WOt2Vn8VJwJmpOQ3LGMI>;
export type CreatePet = (newPetName: StringDoaGddGA, newPetTag: StringDoaGddGA) => Promise<Integer7Bd9WOt2>;
export type GetPet = (petId: Integer7Bd9WOt2) => Promise<ObjectOfStringDoaGddGAStringDoaGddGAInteger7Bd9WOt2Vn8VJwJm>;
